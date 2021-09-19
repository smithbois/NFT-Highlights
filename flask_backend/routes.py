from flask import Blueprint, request, jsonify
from backend.factory import db
from backend.nft_highlights.models import Streamer, create_all_model_db, drop_all_model_db
from stellar_sdk import Server, Keypair, TransactionBuilder, Network
import requests

nfts = Blueprint('nfts', __name__)


@nfts.route('/v1/highlights/database/create', methods=['POST'])
def create_all_database():
    create_all_model_db()
    return "Created db", 200


@nfts.route('/v1/highlights/database/clear', methods=['POST'])
def drop_all_database():
    drop_all_model_db()
    return "Clear db", 200


@nfts.route('/v1/highlights/streamer/<username>', methods=['GET'])
def get_streamer(username):
    try:
        s = Streamer.lookup(username=username)
        data = {
            "username": s.username,
            "clipPrice": s.clip_price,
            "publicAddress": s.public_address,
        }
        return jsonify(data), 200
    except Exception as e:
        return 'An error occurred while retrieving streamer data: ' + str(e), 400


@nfts.route('/v1/highlights/streamer/add', methods=['POST'])
def add_streamer():
    try:
        req = request.get_json(force=True)
        streamer_address = req['streamerAddress']
        streamer_username = req['streamerUsername']
        clip_price = req['clipPrice']
        if clip_price is None:
            clip_price = 100.0
    except Exception as e:
        return 'Error: could not parse request: ' + str(e), 400

    try:
        s = Streamer(username=streamer_username, public_address=streamer_address, clip_price=clip_price)
        db.session.add(s)
        db.session.commit()
    except Exception as e:
        return 'Error adding streamer to database:' + str(e), 400

    return s.username, 200


@nfts.route('/v1/highlights/nft/mint', methods=['POST'])
def mint_highlight_nft():
    try:
        req = request.get_json(force=True)
        clip_url = req['clipUrl']
        clip_url = clip_url.split('?')[0]
        clipper_address = req['clipperAddress']
    except:
        return 'Error: could not parse request', 400

    # extract the streamer's username
    url_segments = clip_url.split('/')
    username = url_segments[3]

    streamer = Streamer.lookup(username=username)
    if streamer is None:
        return 'Error: that streamer is not registered with NFT Highlights', 400

    streamer_address = streamer.public_address
    clip_price = streamer.clip_price

    # this is the private key for our server's wallet
    issuer_keypair = Keypair.random()
    requests.get('https://horizon-testnet.stellar.org/friendbot?addr=' + issuer_keypair.public_key)

    server = Server("https://horizon-testnet.stellar.org")
    issuer_account = server.load_account(issuer_keypair.public_key)
    base_fee = server.fetch_base_fee()
    transaction = (
        TransactionBuilder(
            source_account=issuer_account,
            network_passphrase=Network.TESTNET_NETWORK_PASSPHRASE,
            base_fee=base_fee,
        )
        .append_payment_op(
            source=clipper_address,
            destination=streamer_address,
            amount=str(clip_price),
            asset_code="XLM"
        )
        .append_change_trust_op(
            asset_code="Highlight",
            asset_issuer=issuer_keypair.public_key,
            source=clipper_address,
        )
        .append_payment_op(
            destination=clipper_address,
            asset_code="Highlight",
            asset_issuer=issuer_keypair.public_key,
            amount="1",
            source=issuer_keypair.public_key,
        )
        .append_manage_data_op(
            data_name="highlightURL",
            data_value=url_segments[5]
        )
        .append_manage_data_op(
            data_name="lastSold",
            data_value=str(clip_price)
        )
        .build()
    )
    transaction.sign(issuer_keypair)
    transaction_xdr = transaction.to_xdr()
    print(transaction_xdr)
    return transaction_xdr, 200
