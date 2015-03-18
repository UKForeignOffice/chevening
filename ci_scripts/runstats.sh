#!/bin/bash

set -xe
cd ${WORKSPACE}/chevening_stats
bundle install --path "${HOME}/bundles/${JOB_NAME}" --deployment
bundle exec ruby runStats.rb