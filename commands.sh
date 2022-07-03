https://docs.google.com/document/d/1BTIbtQgzMxtnUbfYrrgnYt8RA9_zZLDNSTUDPh2Lt7k/edit?usp=sharing

# sed -i 's/us-east-2/us-east-2/g' _config.tf
# find ./ -type f -exec sed -i -e 's/udacity-tf-tscotto/udacity-tf-huiren/g' {} \;

aws ec2 describe-availability-zones --region us-east-2


aws ec2 create-restore-image-task --object-key ami-0ec6fdfb365e5fc00.bin --bucket udacity-srend --name "udacity-huiren"
#ami-0a20d0481c46d5b4b
aws ec2 copy-image --source-image-id ami-0a20d0481c46d5b4b --source-region us-east-1 --region us-east-2 --name "udacity-huiren"
#ami-04752855828cc4af2
aws ec2 copy-image --source-image-id ami-0a20d0481c46d5b4b --source-region us-east-1 --region us-west-2 --name "udacity-huiren"
#ami-07cfa214cfed28335

aws s3api create-bucket --bucket terraform-tf-huiren --region us-east-2 --create-bucket-configuration LocationConstraint=us-east-2
aws s3api create-bucket --bucket udacity-tf-huiren-west --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2
aws s3 rm s3://udacity-tf-huiren --recursive
aws s3api delete-bucket --bucket udacity-tf-huiren-west

aws ec2 create-key-pair --key-name udacity --region us-east-2
aws ec2 create-key-pair --key-name udacity --region us-west-2

# helm
export VERIFY_CHECKSUM=false
curl -sSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# terraform
wget https://releases.hashicorp.com/terraform/1.0.7/terraform_1.0.7_linux_amd64.zip
unzip terraform_1.0.7_linux_amd64.zip
mkdir ~/bin
mv terraform ~/bin
export TF_PLUGIN_CACHE_DIR="/tmp"

# kubectl
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc


aws eks update-kubeconfig --name udacity-cluster #--region us-east-2
#Change kubernetes context to the new AWS cluster
kubectl config current-context
# kubectl config use-context docker-desktop
kubectl config use-context arn:aws:eks:us-east-2:376940003530:cluster/udacity-cluster
# e.g  arn:aws:eks:us-east-2:139802095464:cluster/udacity-cluster
kubectl get pods --all-namespaces
kubectl create namespace monitoring
kubectl get pods --namespace monitoring

kubectl create secret generic additional-scrape-configs --from-file=prometheus-additional.yaml --namespace monitoring
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/kube-prometheus-stack -f "values.yaml" --namespace monitoring

# kubectl delete all --all -n monitoring

