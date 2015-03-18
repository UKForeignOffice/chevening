#!/bin/bash

set -xe
cd ${WORKSPACE}/report_capture
bundle install --path "${HOME}/bundles/${JOB_NAME}" --deployment
bundle exec rspec spec/features/capture_reports_spec.rb