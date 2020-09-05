import os
import unittest
from plugins import storage

class TestStoragePlugin(unittest.TestCase):
    def test_file_availablity(self):
        st = storage.Storage(".test.store")
        self.assertFalse(st.destroyed)

    def test_data_destroy(self):
        st = storage.Storage(".test.store")
        st.destroy()
        self.assertTrue(st.destroyed)

if __name__ == "__main__":
    unittest.main()