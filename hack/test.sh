#!/bin/bash

set -euo pipefail

export AWS_ROLE_ARN="arn:aws:iam::214219211678:role/TerraformAWSEKSTests"
source hack/assume_role.sh

export SKIP_cleanup_terraform=true

# export SKIP_deploy_cluster=true
# export SKIP_validate_vpc=true
# export SKIP_validate_cluster=true
export SKIP_validate_standard_node_group=true
export SKIP_validate_bottlerocket_node_group=true
export SKIP_validate_gpu_node_group=true

cd test
go test -v -timeout 90m -run TestTerraformAwsEksCluster | grep -v "constructing many client instances from the same exec auth config"
