#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2022 Vishesh Handa <me@vhanda.in>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

set -eux pipefail

flutter test
# --machine | tee test-results.json
# cat test-results.json | dart run junitreport:tojunit --output test-results.xml