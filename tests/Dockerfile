FROM wata727/tflint:0.9.1

ARG TERRAFORM_VERSION=0.12.4

RUN apk add --no-cache curl git \
  && curl -L https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform.zip \
  && unzip terraform.zip \
  && rm -fr terraform.zip \
  && mv terraform /usr/local/bin

# Any module that uses `kubernetes_priority_class` is disabled from tests pending
# https://github.com/terraform-providers/terraform-provider-kubernetes/pull/495

RUN mkdir -p ~/.terraform.d/plugins \
  && curl -L https://github.com/lawliet89/terraform-provider-kubernetes/releases/download/2019-07-15/terraform-provider-kubernetes_v1.8.0 -o ~/.terraform.d/plugins/terraform-provider-kubernetes_v1.8.0 \
  && chmod +x ~/.terraform.d/plugins/terraform-provider-kubernetes_v1.8.0

COPY tests/lint /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/lint"]

WORKDIR /data
COPY . /data
