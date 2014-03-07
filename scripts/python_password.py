#!/usr/bin/env python

import sys
import keyring

store = sys.argv[1]
username = sys.argv[2]
print keyring.get_password(store,username)
