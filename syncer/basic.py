# standard imports
import logging

# external imports
from chainlib.interface import ChainInterface
from chainlib.eth.block import (
        block_latest,
        block_by_number,
        Block,
        )
from chainlib.eth.tx import (
        receipt,
        Tx,
        )
from chainlib.eth.connection import (
        EthHTTPConnection,
        )
from chainsyncer.driver.chain_interface import ChainInterfaceDriver
from chainsyncer.store.mem import SyncMemStore
from chainsyncer.filter import SyncFilter

logging.basicConfig(level=logging.INFO)
logg = logging.getLogger()


class EthChainInterface(ChainInterface):

    def __init__(self):
        self._block_latest = block_latest
        self._block_by_number = block_by_number
        self._block_from_src = Block.from_src
        self._tx_receipt = receipt
        self._src_normalize = Tx.src_normalize


class BasicFilter(SyncFilter):

    def filter(self, conn, block, tx):
        logg.info('tx {}'.format(tx))


ifc = EthChainInterface()
store = SyncMemStore()
store.register(BasicFilter())
conn = EthHTTPConnection(url='http://localhost:8545')

drv = ChainInterfaceDriver(
            store,
            ifc,
            offset=0,
            target=-1,
            )
drv.run(conn)
