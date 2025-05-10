# k8sonfedora
Setup Kubeadm on Fedora

#### >>install 3 vm from host using cockpit, 1 for control-plane and 2 for workers nodes
#### >>set hostname acccordingly
#### >>set the snapshot for future revert

### In the working directory

# >>create host.ini acccordingly

[control-panel]
ip control-panel

[workers]
ip workers-one
ip workers-two

#### >>inside working directory there are 4 file
1. host.ini (inventory file)
   
2. disable-swap.sh (script file)
   
3. step1-swap-disable.yml (this ansible will run disable-swap.sh script)
   
4. step2-k8s.yml (setup the kubeadm+kubulet)

#### >>from host run ansible-playbook
step 1: ansible-playbook -i hosts.ini step1-swap-disable.yml

step 2: ansible-playbook -i hosts.ini step2-k8s.yml

#### >>ssh to control-panel

run as root in terminal

step 1: kubeadm reset

step 2: kubeadm init

step 3: export KUBECONFIG=/etc/kubernetes/admin.conf

step 4: copy the joincommand

step 5: kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

step 6: transfer the admin.conf to worker nodes

ssh root@192.168.122.197 mkdir -p /root/.kube

scp /etc/kubernetes/admin.conf root@192.168.122.197:/root/.kube/config

..repeat to all workers node

#### >>ssh to worker node

run as root in terminal

step 1: chmod 644 /root/.kube/config

step 2: export KUBECONFIG=/root/.kube/config

step 3: paste the joincommand

..repeat at all workers node

#### >>deploy nginx

Step 1: create the deployment

kubectl create deployment nginx --image=nginx:latest

Step 2 : expose to create service

kubectl expose deployment nginx --name=nginx-loadbalancer --type=LoadBalancer --port=90 --target-port=80


