#!/bin/bash

curl -s -LO "https://dl.k8s.io/release/v$KUBECTL_BINARY_VERSION/bin/linux/$KUBECTL_BINARY_ARCH/kubectl"
chmod +x kubectl

last_ip=not_fetched_yet

# TODO right now this does not catch additional added loadbalancers until the next IP change
# TODO logging time format is ugly
while true; do
  current_ip=$(curl -s https://ifconfig.me/ip);
  if [ "$last_ip" != "$current_ip" ]; then
    echo 'status: { loadBalancer: {  ingress: [{ ip: "'$current_ip'" } ]} }' > patchfile.yaml
    # retrieve all loadbalancer services
    for svc_namespace_and_name in $(./kubectl get services --all-namespaces --output=jsonpath='{range .items[?(@.spec.type=="LoadBalancer")]}{.metadata.namespace}{";"}{@.metadata.name}{"\n"}{end}'); do
      echo $(date)" - "$(./kubectl patch service -n $(echo $svc_namespace_and_name | cut -d';' -f1) $(echo $svc_namespace_and_name | cut -d';' -f2)  --type=merge --subresource status --patch-file patchfile.yaml)
    done
    echo $(date)" - updated external ip to "$current_ip
  fi;
  rm -rf patchfile.yaml
  last_ip=$current_ip
  sleep $DETERMINE_EXERNAL_IP_INTERVALL
done