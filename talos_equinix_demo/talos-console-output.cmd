~ % talosctl cluster create 
validating CIDR and reserving IPs
generating PKI and tokens
creating network talos-default
creating controlplane nodes
creating worker nodes
renamed talosconfig context "talos-default" -> "talos-default-2"
waiting for API
bootstrapping cluster
waiting for etcd to be healthy: OK
waiting for etcd members to be consistent across nodes: OK
waiting for etcd members to be control plane nodes: OK
waiting for apid to be ready: OK
waiting for all nodes memory sizes: OK
waiting for all nodes disk sizes: OK
waiting for kubelet to be healthy: OK
waiting for all nodes to finish boot sequence: OK
waiting for all k8s nodes to report: OK
waiting for all k8s nodes to report ready: OK
waiting for all control plane static pods to be running: OK
waiting for all control plane components to be ready: OK
waiting for kube-proxy to report ready: OK
waiting for coredns to report ready: OK
waiting for all k8s nodes to report schedulable: OK

merging kubeconfig into "/Users/gsaravanan/.kube/config"
renamed cluster "talos-default" -> "talos-default-2"
renamed auth info "admin@talos-default" -> "admin@talos-default-2"
renamed context "admin@talos-default" -> "admin@talos-default-2"
PROVISIONER           docker
NAME                  talos-default
NETWORK NAME          talos-default
NETWORK CIDR          10.5.0.0/24
NETWORK GATEWAY       10.5.0.1
NETWORK MTU           1500
KUBERNETES ENDPOINT   https://127.0.0.1:50009

NODES:

NAME                            TYPE           IP         CPU    RAM      DISK
/talos-default-controlplane-1   controlplane   10.5.0.2   2.00   2.1 GB   -
/talos-default-worker-1         worker         10.5.0.3   2.00   2.1 GB   -
gsaravanan@gs-macbook-pro ~ % talosctl gen config talos-k8s-em-tutorial https://127.0.0.1:50009
generating PKI and tokens
Created /Users/gsaravanan/controlplane.yaml
Created /Users/gsaravanan/worker.yaml
Created /Users/gsaravanan/talosconfig
gsaravanan@gs-macbook-pro ~ % talosctl validate --config controlplane.yaml --mode metal
controlplane.yaml is valid for metal mode
gsaravanan@gs-macbook-pro ~ % talosctl validate --config worker.yaml --mode metal
worker.yaml is valid for metal mode
gsaravanan@gs-macbook-pro ~ % cat /Users/gsaravanan/controlplane.yaml
version: v1alpha1 # Indicates the schema used to decode the contents.
debug: false # Enable verbose logging to the console.
persist: true
# Provides machine specific configuration options.
machine:
    type: controlplane # Defines the role of the machine within the cluster.
    token: 39ej7j.s43bl114d0r2hole # The `token` is used by a machine to join the PKI of the cluster.
    # The root certificate authority of the PKI.
    ca:
        crt: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJQakNCOGFBREFnRUNBaEFkSTVwZ1pXdDF0M0VNZVVjMmY4cTFNQVVHQXl0bGNEQVFNUTR3REFZRFZRUUsKRXdWMFlXeHZjekFlRncweU5EQTFNak15TURVek5EVmFGdzB6TkRBMU1qRXlNRFV6TkRWYU1CQXhEakFNQmdOVgpCQW9UQlhSaGJHOXpNQ293QlFZREsyVndBeUVBczRJZ28zREhOTU53RzVOWEJUaGFDcjl0OWpWdmZJeW52S1NxCmp5eVgzTStqWVRCZk1BNEdBMVVkRHdFQi93UUVBd0lDaERBZEJnTlZIU1VFRmpBVUJnZ3JCZ0VGQlFjREFRWUkKS3dZQkJRVUhBd0l3RHdZRFZSMFRBUUgvQkFVd0F3RUIvekFkQmdOVkhRNEVGZ1FVMmVQTEVXQ1hHbVFBc09rbApLaUI5RU5aT0tkVXdCUVlESzJWd0EwRUF5NFpYRnMydVZkUVcyUDRTeVh5OHhnUHBPcEY1N0E2VUIzQWtEZzl1CnVKbGM1WGJ2SzZ2dlNvYkJrMys5MW1HdjlPN2FhRGdDY1RZRkh2MExUcjBrQXc9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
        key: LS0tLS1CRUdJTiBFRDI1NTE5IFBSSVZBVEUgS0VZLS0tLS0KTUM0Q0FRQXdCUVlESzJWd0JDSUVJTnl2MjdVNU9EMGZkN2pTTG1GTGNYb0dKc1ZwWG92amZpNXdDdlFiM2t4VQotLS0tLUVORCBFRDI1NTE5IFBSSVZBVEUgS0VZLS0tLS0K
    # Extra certificate subject alternative names for the machine's certificate.
    certSANs: []
    #   # Uncomment this to enable SANs.
    #   - 10.0.0.10
    #   - 172.16.0.10
    #   - 192.168.0.10

    # Used to provide additional options to the kubelet.
    kubelet:
        image: ghcr.io/siderolabs/kubelet:v1.30.0 # The `image` field is an optional reference to an alternative kubelet image.
        defaultRuntimeSeccompProfileEnabled: true # Enable container runtime default Seccomp profile.
        disableManifestsDirectory: true # The `disableManifestsDirectory` field configures the kubelet to get static pod manifests from the /etc/kubernetes/manifests directory.
        
        # # The `ClusterDNS` field is an optional reference to an alternative kubelet clusterDNS ip list.
        # clusterDNS:
        #     - 10.96.0.10
        #     - 169.254.2.53

        # # The `extraArgs` field is used to provide additional flags to the kubelet.
        # extraArgs:
        #     key: value

        # # The `extraMounts` field is used to add additional mounts to the kubelet container.
        # extraMounts:
        #     - destination: /var/lib/example # Destination is the absolute path where the mount will be placed in the container.
        #       type: bind # Type specifies the mount kind.
        #       source: /var/lib/example # Source specifies the source path of the mount.
        #       # Options are fstab style mount options.
        #       options:
        #         - bind
        #         - rshared
        #         - rw

        # # The `extraConfig` field is used to provide kubelet configuration overrides.
        # extraConfig:
        #     serverTLSBootstrap: true

        # # The `KubeletCredentialProviderConfig` field is used to provide kubelet credential configuration.
        # credentialProviderConfig:
        #     apiVersion: kubelet.config.k8s.io/v1
        #     kind: CredentialProviderConfig
        #     providers:
        #         - apiVersion: credentialprovider.kubelet.k8s.io/v1
        #           defaultCacheDuration: 12h
        #           matchImages:
        #             - '*.dkr.ecr.*.amazonaws.com'
        #             - '*.dkr.ecr.*.amazonaws.com.cn'
        #             - '*.dkr.ecr-fips.*.amazonaws.com'
        #             - '*.dkr.ecr.us-iso-east-1.c2s.ic.gov'
        #             - '*.dkr.ecr.us-isob-east-1.sc2s.sgov.gov'
        #           name: ecr-credential-provider

        # # The `nodeIP` field is used to configure `--node-ip` flag for the kubelet.
        # nodeIP:
        #     # The `validSubnets` field configures the networks to pick kubelet node IP from.
        #     validSubnets:
        #         - 10.0.0.0/8
        #         - '!10.0.0.3/32'
        #         - fdc7::/16
    # Provides machine specific network configuration options.
    network: {}
    # # `interfaces` is used to define the network interface configuration.
    # interfaces:
    #     - interface: enp0s1 # The interface name.
    #       # Assigns static IP addresses to the interface.
    #       addresses:
    #         - 192.168.2.0/24
    #       # A list of routes associated with the interface.
    #       routes:
    #         - network: 0.0.0.0/0 # The route's network (destination).
    #           gateway: 192.168.2.1 # The route's gateway (if empty, creates link scope route).
    #           metric: 1024 # The optional metric for the route.
    #       mtu: 1500 # The interface's MTU.
    #       
    #       # # Picks a network device using the selector.

    #       # # select a device with bus prefix 00:*.
    #       # deviceSelector:
    #       #     busPath: 00:* # PCI, USB bus prefix, supports matching by wildcard.
    #       # # select a device with mac address matching `*:f0:ab` and `virtio` kernel driver.
    #       # deviceSelector:
    #       #     hardwareAddr: '*:f0:ab' # Device hardware address, supports matching by wildcard.
    #       #     driver: virtio # Kernel driver, supports matching by wildcard.
    #       # # select a device with bus prefix 00:*, a device with mac address matching `*:f0:ab` and `virtio` kernel driver.
    #       # deviceSelector:
    #       #     - busPath: 00:* # PCI, USB bus prefix, supports matching by wildcard.
    #       #     - hardwareAddr: '*:f0:ab' # Device hardware address, supports matching by wildcard.
    #       #       driver: virtio # Kernel driver, supports matching by wildcard.

    #       # # Bond specific options.
    #       # bond:
    #       #     # The interfaces that make up the bond.
    #       #     interfaces:
    #       #         - enp2s0
    #       #         - enp2s1
    #       #     # Picks a network device using the selector.
    #       #     deviceSelectors:
    #       #         - busPath: 00:* # PCI, USB bus prefix, supports matching by wildcard.
    #       #         - hardwareAddr: '*:f0:ab' # Device hardware address, supports matching by wildcard.
    #       #           driver: virtio # Kernel driver, supports matching by wildcard.
    #       #     mode: 802.3ad # A bond option.
    #       #     lacpRate: fast # A bond option.

    #       # # Bridge specific options.
    #       # bridge:
    #       #     # The interfaces that make up the bridge.
    #       #     interfaces:
    #       #         - enxda4042ca9a51
    #       #         - enxae2a6774c259
    #       #     # A bridge option.
    #       #     stp:
    #       #         enabled: true # Whether Spanning Tree Protocol (STP) is enabled.

    #       # # Indicates if DHCP should be used to configure the interface.
    #       # dhcp: true

    #       # # DHCP specific options.
    #       # dhcpOptions:
    #       #     routeMetric: 1024 # The priority of all routes received via DHCP.

    #       # # Wireguard specific configuration.

    #       # # wireguard server example
    #       # wireguard:
    #       #     privateKey: ABCDEF... # Specifies a private key configuration (base64 encoded).
    #       #     listenPort: 51111 # Specifies a device's listening port.
    #       #     # Specifies a list of peer configurations to apply to a device.
    #       #     peers:
    #       #         - publicKey: ABCDEF... # Specifies the public key of this peer.
    #       #           endpoint: 192.168.1.3 # Specifies the endpoint of this peer entry.
    #       #           # AllowedIPs specifies a list of allowed IP addresses in CIDR notation for this peer.
    #       #           allowedIPs:
    #       #             - 192.168.1.0/24
    #       # # wireguard peer example
    #       # wireguard:
    #       #     privateKey: ABCDEF... # Specifies a private key configuration (base64 encoded).
    #       #     # Specifies a list of peer configurations to apply to a device.
    #       #     peers:
    #       #         - publicKey: ABCDEF... # Specifies the public key of this peer.
    #       #           endpoint: 192.168.1.2:51822 # Specifies the endpoint of this peer entry.
    #       #           persistentKeepaliveInterval: 10s # Specifies the persistent keepalive interval for this peer.
    #       #           # AllowedIPs specifies a list of allowed IP addresses in CIDR notation for this peer.
    #       #           allowedIPs:
    #       #             - 192.168.1.0/24

    #       # # Virtual (shared) IP address configuration.

    #       # # layer2 vip example
    #       # vip:
    #       #     ip: 172.16.199.55 # Specifies the IP address to be used.

    # # Used to statically set the nameservers for the machine.
    # nameservers:
    #     - 8.8.8.8
    #     - 1.1.1.1

    # # Allows for extra entries to be added to the `/etc/hosts` file
    # extraHostEntries:
    #     - ip: 192.168.1.100 # The IP of the host.
    #       # The host alias.
    #       aliases:
    #         - example
    #         - example.domain.tld

    # # Configures KubeSpan feature.
    # kubespan:
    #     enabled: true # Enable the KubeSpan feature.

    # Used to provide instructions for installations.
    install:
        disk: /dev/sda # The disk used for installations.
        image: ghcr.io/siderolabs/installer:v1.7.1 # Allows for supplying the image used to perform the installation.
        wipe: false # Indicates if the installation disk should be wiped at installation time.
        
        # # Look up disk using disk attributes like model, size, serial and others.
        # diskSelector:
        #     size: 4GB # Disk size.
        #     model: WDC* # Disk model `/sys/block/<dev>/device/model`.
        #     busPath: /pci0000:00/0000:00:17.0/ata1/host0/target0:0:0/0:0:0:0 # Disk bus path.

        # # Allows for supplying extra kernel args via the bootloader.
        # extraKernelArgs:
        #     - talos.platform=metal
        #     - reboot=k

        # # Allows for supplying additional system extension images to install on top of base Talos image.
        # extensions:
        #     - image: ghcr.io/siderolabs/gvisor:20220117.0-v1.0.0 # System extension image.
    # Used to configure the machine's container image registry mirrors.
    registries: {}
    # # Specifies mirror configuration for each registry host namespace.
    # mirrors:
    #     ghcr.io:
    #         # List of endpoints (URLs) for registry mirrors to use.
    #         endpoints:
    #             - https://registry.insecure
    #             - https://ghcr.io/v2/

    # # Specifies TLS & auth configuration for HTTPS image registries.
    # config:
    #     registry.insecure:
    #         # The TLS configuration for the registry.
    #         tls:
    #             insecureSkipVerify: true # Skip TLS server certificate verification (not recommended).
    #             
    #             # # Enable mutual TLS authentication with the registry.
    #             # clientIdentity:
    #             #     crt: LS0tIEVYQU1QTEUgQ0VSVElGSUNBVEUgLS0t
    #             #     key: LS0tIEVYQU1QTEUgS0VZIC0tLQ==
    #         
    #         # # The auth configuration for this registry.
    #         # auth:
    #         #     username: username # Optional registry authentication.
    #         #     password: password # Optional registry authentication.

    # Features describe individual Talos features that can be switched on or off.
    features:
        rbac: true # Enable role-based access control (RBAC).
        stableHostname: true # Enable stable default hostname.
        apidCheckExtKeyUsage: true # Enable checks for extended key usage of client certificates in apid.
        diskQuotaSupport: true # Enable XFS project quota support for EPHEMERAL partition and user disks.
        # KubePrism - local proxy/load balancer on defined port that will distribute
        kubePrism:
            enabled: true # Enable KubePrism support - will start local load balancing proxy.
            port: 7445 # KubePrism port.
        # Configures host DNS caching resolver.
        hostDNS:
            enabled: true # Enable host DNS caching resolver.
        
        # # Configure Talos API access from Kubernetes pods.
        # kubernetesTalosAPIAccess:
        #     enabled: true # Enable Talos API access from Kubernetes pods.
        #     # The list of Talos API roles which can be granted for access from Kubernetes pods.
        #     allowedRoles:
        #         - os:reader
        #     # The list of Kubernetes namespaces Talos API access is available from.
        #     allowedKubernetesNamespaces:
        #         - kube-system
    
    # # Provides machine specific control plane configuration options.

    # # ControlPlane definition example.
    # controlPlane:
    #     # Controller manager machine specific configuration options.
    #     controllerManager:
    #         disabled: false # Disable kube-controller-manager on the node.
    #     # Scheduler machine specific configuration options.
    #     scheduler:
    #         disabled: true # Disable kube-scheduler on the node.

    # # Used to provide static pod definitions to be run by the kubelet directly bypassing the kube-apiserver.

    # # nginx static pod.
    # pods:
    #     - apiVersion: v1
    #       kind: pod
    #       metadata:
    #         name: nginx
    #       spec:
    #         containers:
    #             - image: nginx
    #               name: nginx

    # # Used to partition, format and mount additional disks.

    # # MachineDisks list example.
    # disks:
    #     - device: /dev/sdb # The name of the disk to use.
    #       # A list of partitions to create on the disk.
    #       partitions:
    #         - mountpoint: /var/mnt/extra # Where to mount the partition.
    #           
    #           # # The size of partition: either bytes or human readable representation. If `size:` is omitted, the partition is sized to occupy the full disk.

    #           # # Human readable representation.
    #           # size: 100 MB
    #           # # Precise value in bytes.
    #           # size: 1073741824

    # # Allows the addition of user specified files.

    # # MachineFiles usage example.
    # files:
    #     - content: '...' # The contents of the file.
    #       permissions: 0o666 # The file's permissions in octal.
    #       path: /tmp/file.txt # The path of the file.
    #       op: append # The operation to use

    # # The `env` field allows for the addition of environment variables.

    # # Environment variables definition examples.
    # env:
    #     GRPC_GO_LOG_SEVERITY_LEVEL: info
    #     GRPC_GO_LOG_VERBOSITY_LEVEL: "99"
    #     https_proxy: http://SERVER:PORT/
    # env:
    #     GRPC_GO_LOG_SEVERITY_LEVEL: error
    #     https_proxy: https://USERNAME:PASSWORD@SERVER:PORT/
    # env:
    #     https_proxy: http://DOMAIN\USERNAME:PASSWORD@SERVER:PORT/

    # # Used to configure the machine's time settings.

    # # Example configuration for cloudflare ntp server.
    # time:
    #     disabled: false # Indicates if the time service is disabled for the machine.
    #     # description: |
    #     servers:
    #         - time.cloudflare.com
    #     bootTimeout: 2m0s # Specifies the timeout when the node time is considered to be in sync unlocking the boot sequence.

    # # Used to configure the machine's sysctls.

    # # MachineSysctls usage example.
    # sysctls:
    #     kernel.domainname: talos.dev
    #     net.ipv4.ip_forward: "0"
    #     net/ipv6/conf/eth0.100/disable_ipv6: "1"

    # # Used to configure the machine's sysfs.

    # # MachineSysfs usage example.
    # sysfs:
    #     devices.system.cpu.cpu0.cpufreq.scaling_governor: performance

    # # Machine system disk encryption configuration.
    # systemDiskEncryption:
    #     # Ephemeral partition encryption.
    #     ephemeral:
    #         provider: luks2 # Encryption provider to use for the encryption.
    #         # Defines the encryption keys generation and storage method.
    #         keys:
    #             - # Deterministically generated key from the node UUID and PartitionLabel.
    #               nodeID: {}
    #               slot: 0 # Key slot number for LUKS2 encryption.
    #               
    #               # # KMS managed encryption key.
    #               # kms:
    #               #     endpoint: https://192.168.88.21:4443 # KMS endpoint to Seal/Unseal the key.
    #         
    #         # # Cipher kind to use for the encryption. Depends on the encryption provider.
    #         # cipher: aes-xts-plain64

    #         # # Defines the encryption sector size.
    #         # blockSize: 4096

    #         # # Additional --perf parameters for the LUKS2 encryption.
    #         # options:
    #         #     - no_read_workqueue
    #         #     - no_write_workqueue

    # # Configures the udev system.
    # udev:
    #     # List of udev rules to apply to the udev system
    #     rules:
    #         - SUBSYSTEM=="drm", KERNEL=="renderD*", GROUP="44", MODE="0660"

    # # Configures the logging system.
    # logging:
    #     # Logging destination.
    #     destinations:
    #         - endpoint: tcp://1.2.3.4:12345 # Where to send logs. Supported protocols are "tcp" and "udp".
    #           format: json_lines # Logs format.

    # # Configures the kernel.
    # kernel:
    #     # Kernel modules to load.
    #     modules:
    #         - name: brtfs # Module name.

    # # Configures the seccomp profiles for the machine.
    # seccompProfiles:
    #     - name: audit.json # The `name` field is used to provide the file name of the seccomp profile.
    #       # The `value` field is used to provide the seccomp profile.
    #       value:
    #         defaultAction: SCMP_ACT_LOG

    # # Configures the node labels for the machine.

    # # node labels example.
    # nodeLabels:
    #     exampleLabel: exampleLabelValue

    # # Configures the node taints for the machine. Effect is optional.

    # # node taints example.
    # nodeTaints:
    #     exampleTaint: exampleTaintValue:NoSchedule
# Provides cluster specific configuration options.
cluster:
    id: JuFmX-dw1iUGt_oX2YO4J67vV_nieLbFNGOzmgKju1Q= # Globally unique identifier for this cluster (base64 encoded random 32 bytes).
    secret: NZMRFfN2zCxjlZGd5DI6I2HzmpZCbTgOcqBDcvl0OLE= # Shared secret of cluster (base64 encoded random 32 bytes).
    # Provides control plane specific configuration options.
    controlPlane:
        endpoint: https://127.0.0.1:50009 # Endpoint is the canonical controlplane endpoint, which can be an IP address or a DNS hostname.
    clusterName: talos-k8s-em-tutorial # Configures the cluster's name.
    # Provides cluster specific network configuration options.
    network:
        dnsDomain: cluster.local # The domain used by Kubernetes DNS.
        # The pod subnet CIDR.
        podSubnets:
            - 10.244.0.0/16
        # The service subnet CIDR.
        serviceSubnets:
            - 10.96.0.0/12
        
        # # The CNI used.
        # cni:
        #     name: custom # Name of CNI to use.
        #     # URLs containing manifests to apply for the CNI.
        #     urls:
        #         - https://docs.projectcalico.org/archive/v3.20/manifests/canal.yaml
    token: xenrvf.spdfsyutdxndnmkr # The [bootstrap token](https://kubernetes.io/docs/reference/access-authn-authz/bootstrap-tokens/) used to join the cluster.
    secretboxEncryptionSecret: lW+7jlZwoWTVYs1tznvJAp1FGC6TFY3R8sElhu5BxBo= # A key used for the [encryption of secret data at rest](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/).
    # The base64 encoded root certificate authority used by Kubernetes.
    ca:
        crt: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJpekNDQVRDZ0F3SUJBZ0lSQVBPRTNwQVZnZGdMSklHUDdEeGlPbjh3Q2dZSUtvWkl6ajBFQXdJd0ZURVQKTUJFR0ExVUVDaE1LYTNWaVpYSnVaWFJsY3pBZUZ3MHlOREExTWpNeU1EVXpORFZhRncwek5EQTFNakV5TURVegpORFZhTUJVeEV6QVJCZ05WQkFvVENtdDFZbVZ5Ym1WMFpYTXdXVEFUQmdjcWhrak9QUUlCQmdncWhrak9QUU1CCkJ3TkNBQVIzdDBzcFNBQnFmcStKSEcvNFZpWCtJVjlBUkpCKytBak53Z3d6SStGWlVtN2VuazYzaElUZkFCVVkKL2ZEOUpFdHQybHBnZjNOZW0xRmdlbEFzMkNYSm8yRXdYekFPQmdOVkhROEJBZjhFQkFNQ0FvUXdIUVlEVlIwbApCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEdBMVVkRXdFQi93UUZNQU1CQWY4d0hRWURWUjBPCkJCWUVGSUxnbzVxSmVhZHdMSmZlRCs3M3R1VmY3amdZTUFvR0NDcUdTTTQ5QkFNQ0Ewa0FNRVlDSVFEQjUrbVUKUnhnQll6TGd3NGJlZXlhOEllU0ZxZWxZRXZLbUMxTWhSSWFGUkFJaEFQcFJKekl0dGdpTC9aNkF0Y1hnbGpqNQpBT1NETDVSSXhkd2o4cmlnZjJQeQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
        key: LS0tLS1CRUdJTiBFQyBQUklWQVRFIEtFWS0tLS0tCk1IY0NBUUVFSU1yU2h6NHJoTFZ0UldhNldoNWVmdSsyNGM0YjRjb2hSY096VTJ5eDdqNkxvQW9HQ0NxR1NNNDkKQXdFSG9VUURRZ0FFZDdkTEtVZ0FhbjZ2aVJ4ditGWWwvaUZmUUVTUWZ2Z0l6Y0lNTXlQaFdWSnUzcDVPdDRTRQozd0FWR1Azdy9TUkxiZHBhWUg5elhwdFJZSHBRTE5nbHlRPT0KLS0tLS1FTkQgRUMgUFJJVkFURSBLRVktLS0tLQo=
    # The base64 encoded aggregator certificate authority used by Kubernetes for front-proxy certificate generation.
    aggregatorCA:
        crt: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJYekNDQVFhZ0F3SUJBZ0lSQUxocWhyUkgyeFB4Q04weFBhRHNZa2N3Q2dZSUtvWkl6ajBFQXdJd0FEQWUKRncweU5EQTFNak15TURVek5EVmFGdzB6TkRBMU1qRXlNRFV6TkRWYU1BQXdXVEFUQmdjcWhrak9QUUlCQmdncQpoa2pPUFFNQkJ3TkNBQVQ3ZFFGT0xlWWxFdnpKVmFJMXg0ZHpVZVl5bXNVdmZRb0lKSGUwME5zbXJFSmpRaVVUCnlDekRzV252U0g1azlDZ21GL0cwNDBLSVFGbFRMK1lPRitZdm8yRXdYekFPQmdOVkhROEJBZjhFQkFNQ0FvUXcKSFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEdBMVVkRXdFQi93UUZNQU1CQWY4dwpIUVlEVlIwT0JCWUVGTEJiY0FiUTN1OG9HNVJZR3c4TGhDem0xaEJZTUFvR0NDcUdTTTQ5QkFNQ0EwY0FNRVFDCklIeVkwYk5VQmZxZXNBRlg1ZTNvM0hVSDMwc29GVzc4dzFnSmlUL3JnZUlzQWlBcml1NTdMRGZ6M0Y2Y3h2akEKWkd4bGRVaXo1d3ppSGkxMzdBcHJrQWJtV0E9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
        key: LS0tLS1CRUdJTiBFQyBQUklWQVRFIEtFWS0tLS0tCk1IY0NBUUVFSUw2NUFBSGxEd3dFMStIam12dVNJd2ljWGtzZ0NTQlYxRUNhQXBBWmRiMkJvQW9HQ0NxR1NNNDkKQXdFSG9VUURRZ0FFKzNVQlRpM21KUkw4eVZXaU5jZUhjMUhtTXByRkwzMEtDQ1IzdE5EYkpxeENZMElsRThncwp3N0ZwNzBoK1pQUW9KaGZ4dE9OQ2lFQlpVeS9tRGhmbUx3PT0KLS0tLS1FTkQgRUMgUFJJVkFURSBLRVktLS0tLQo=
    # The base64 encoded private key for service account token generation.
    serviceAccount:
        key: LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlKS0FJQkFBS0NBZ0VBdU5Yb3BrVkRRQVNBaGNrdng5ZURjd2NPbGxLVDZqd2J1M2VFSVMxMzJ3M3dEbnlvCk1odzhZZFBXWXc1Y3NXeUtTckJ6aDdvQ3dXZGpqTklFTjlvSWVkU2ZWcm43TWVqZjBDSG51RnN3Y1FLZmcwK04KK2tEWkpVOG52alZOeEhFc1dOem9jTXpqQU9lUDJvUWFmY1ljc3c1cytKVHI3cmRVZEhBeks1V0lFRW8zS29QVgpidlZDWHA3WUtVRnliRTVwWVV6L3pmYm5YZ0lWKzB5VGppTXBVNW1XOTlHenh6MCt4Z0VLdW9Nckw1cEhRZUdPCndnY1p6Z2J1cTdRWFo5OTlEZUFVNCtISkpWc29IUm9xdnUyWmtyZ1VkMHJ2OWdIbXY4cVFVMUVNTlZYdnlzWWkKWjlMbFVpbllxQTZWeXptZmU4SFVLUFIyYUNIclpVTEFRM2pnUG9aSnd5U29xUElnWVZaUTVLNXEwWE9hdjRIcApUOGwvOUh1OWI1a2dSSmV0bHFUYW53eGswNDBadkJMMEdQdHZFRDh0dElFK1VzM0pJTTBHUXRDR1B6c0ZPcTdCCnl0aGhjZ2dIWDBTTVc3a0NsemRSZjJhNWJ1U1RjbGJWMERmN3I1OWJVVDZyR3RmVGZ1VmNBYVBxNnI3TlptaHoKUUR6dDJZTldrdjZKWDF0bUMyQkNxUm40OUZJeVB2RU5BeGxJQkd1c0hGcUpXa3l4cmFoNmRUNVVuVWhQRGZjcgo3NWVVTHFsMG9LWDcvMjVncVlkdGNPMndYZTBIaFdUM2kwL3JibmcrRUdnYjBma2VnYUpGOGJPOVR2V0ZIc0k2CjcwdzJqNklTaDB1UHIvTzFiZ290NHNUSG95R3d6ZGx0TDVJcHYyUStjV0JyNFlYT1RFMEUvKzZwdlBFQ0F3RUEKQVFLQ0FnQUg5QXhpdXpBOW5QUDZ6Y0Zray8xd0FhbTdCaXFmTlo3cjNpU3RXTXVEZllJSzNZcFBQYS9MZGRZUAp4UnB2OS8rclh4Ulpqc04zbHY5Tm0rdmFpMk01K3RBd1p5aEw2WDFYODEySkxVTlVXWXlMbGV6Q0MvQk1EcS9qCkcyQVJSOTFrcFh6Sy9jWDJ6Ly84b3hxUXR1bWRPczJ0bEpyaVZya25tWHhhTDhEL0VuSjFQZDc5TzBoejBkbnoKVElHajcydlJhQUxKMWduMm5aaGNpOXI5anIzRWZ5TmozbjRoNEp6RzRGeVowZk1WeFVtenFBVUFqRldyNjloeApRdnFPMmFzRDRkU0VTYjdpQUo0bFFtNzhjRFRmZjFSQ0hkTmRmbzl6U1VBVWxiUTB4MUhlSTlCdkx6LzIzUjRaCmZTY3M2M25WVlczUHBWVkMvZEtuTk13Wkd5WnE5NWw2N25PRXA5NkZibm1wSlhucW1Wb1c0RFNxVU9NMmtuSlIKcnlqbS9JSjRCTnk4QkxQcTM5aDFUVHRTeDBjTWw5Nys5MnpTSUQ2WVJrcDlZR2RFdHlrS1QySXRwQ1psdDhzSQptRlFHNmM4aUdMRTk5ODFPRVpzdE85d013dzRtSXJielA1ck9ZUEJKcWd1Yng2ZEtUeGViQURvQVNwb044R1d4Ck03OEtSRms1OTliYVFFMWFSQ3JhbFREcjRQUHIxS0VwaXZFa0ExaVMycm9oRjZ4MG9aTHFCd2RwZzBvU3VhS00KTGduZHh1UGVzNVZIMXpIVVZJQ0lVa0JzdXVHajI3QytWMDYyeVphdnFhd3hYMVcyL1JpakJ5OXZEWWJDTDZ0dwpvOXNlLzdGeXdvempNckJmS1VqS0MzRTViSTYyVGxRb0FVS3VtcmpIb0ZkVHRoa1lBUUtDQVFFQTRKSFB6eXdwCm4vcG1pRUZPZWtxcTlqZ2NlaHNncHFCOE1UejF0VzdzRm5Hb3gxZUtjTXY3QjMvbHFETXZPeHpJbENwYVpEU1kKNUJaREYzUmhwcktjRDB5YUFIMnlLdEVUTW1kY1k2aXJWVk4xVlV5TXUvazhFZy9hRFJNTmx6QXhnRTAxVU1yOQpyVlN6ekhDSXphV3lPRkd0YXRzcjU4TnFCTi9VZEIwZHRyUHpEZWhnT0xZeXoxNklYK1Jla1FUUEZ2am83L09CClVOZ2ErcGh2c0dVWWxOWmV2YStQeXNwWGNqK3RMNWxsWUVrbzVON1QvTWpXSmRMRVdXeTlSYmlSL01jOVNIMjIKM0NkZUhickV0Y29wWDQ3a3pqSys5am1uK2hQYWs4RGxFSU1kSXZnSzk0QVhhUXhJd1dvemFTdDgzUno5SUdPVAp4SFd3VGlxc1FJS0RZUUtDQVFFQTByUno0b1NSSzE2Q0tJOXdoSFhYQ0dYaVhrVVBDbWV3YkkzbVZBWjc5bVBUCkRob1BCOUFVR0Z5NnFwc2x5d3lTa2FISE1XUmRsV09vblAxa3RxaXdCY3dhU2FNa0ZpT2d1VHZCTmlxUS9vMEIKOGJHTlF2YmNJcWFQVEMrajJCYU03a3hqTzJXUDcyMTlpbllFdEpXbnlYeWZPV3NCWlVzUk9TUXJ0Wnk3V0IrTQpEM2JJRElJUm4ybHVxa0pUdjlhUWJKTnBnd2l3UlNXZzU0ZWUvYUxmVEFYNWZPVkVVaGRkbU1WTzZtWGkrVDZUCk5DdUlrQ21wVmpLQUtDazN4VnFPU21ObEYrVnpVdS9EUWhzTzVWY29QRTRYSEIxbzVVR1BqNFNqVnoxSS8zcTMKcXBubjBWQVh2RWRDUWpNemprcWVUWWk3U3d1VmhwT1Z1SUNobnpFemtRS0NBUUVBdHdQZUdmYmh6WERpVXJUMgpZZytzR0pGT0UrMDd4TkFScG9jSnI5MUFKbUptckY2WmdxZWFZMWhHTDdmWERCTy9HNUVRclkxMzlKcDMvd3RuCjhkU3Avb1h0RSsxY1lDeVh1b0lsOTBva3A1c21pbWVpWWljU1g1M3ZsS3dzYlVSbmN5cDVBdWtMcUZEWlh3bHYKVkRsdmJ4cVJlLzQyWCtFUDYvMEdSY0xjem1NRStCYWpKRlRJUDl2SXhHMTI3RFRCR1BXdDBLL2dlYVJGQ0dsbQp6SmozV1lVREhRK1EzakhjNWswaXRTSU1UbFlSTDhTeGV0ZXFQcFR3VS9pY244OTFtazQ5a1hCeXNDU2RQUmxTCjZ0eGdyM0hpNG5EVTFCSFU1YWQ4Z09HNVRLV3QveXVxdEYzOXRpeSt0bkg0aUFOYTlWQ0VzZnExR0d6WlREclcKdXBRaXdRS0NBUUJYNzFXWnlJZXBXT1RyTm9uWHpqSXk0QXBzRzFnZW1JMkprR0w2MkVYdDIxVmV3a05abUY1NgptR0NUQ1BMcDNkSmhrdW5GMUVRMkw0UlVHSEJxeHRYSFpabm05MzM4KzF0OVV0SGM0RURvNjBKUGN6RW9MRXhNCjdjUktJR3U1cUJlaThDQk56cUlXWTFTTWI1cWhId0FLVjhjL3VFZTUxVzFYc3AvSFNLVHJMeWRONE4yMlVxWTIKS0ZNMkhUNUVockI1ajcvdUhyY3A5SDFGZzFVNE56d0h4MHFLOUVmaUZyeEtJTFpCbnNudUNVNTM3Rjh2QXlRWAp4RFcyRFJXb2VKVi91Q0dkcW5YSnZDUjZOejZ0T2dXaHZWbHBzMkJ1cFVEYnZaaEp0VnI4dkdOZ2dLQzl1elpjCnJrU1p5aktQQk5jeU5va3IxYWJPcGxOS3ord2p1dTN4QW9JQkFDSWNUb0svOGhmQjU0bUprTmczKzVMY0FJeGwKV0xOWERFc3FhbjZTYXd1ZWJlWnBHbk5WVk1SNXdxMENYSElmRWowQUFpSERUQkF0Z2xNMUIvNTZaUFRIZlFmeApqdU14aHlTZFYySU5JTmNhRVdLNUE4eFBydTBDV0ZDUldrdmtoK2p6MXNoOGY2THJuS2N5THMycDc2ZkZYOFVyCjFUMTAyOTY5aE9jTk1PWGZZeWZTcmhYbks4d3NHemN1c0pEbndKTWZoTGJiZ0cwK3BCb09JRWE0UCtMSHhMWXgKSENXc2N1RmFJVzJ3VVVibS95Wk8zOTQ2WnB3NTNnSjR5Nm1Ua2oxUnp1TURtV1BMYWNqMXQ0TllDQk05MTRqaQpzRTIyeWR5Vkwwbks3QVBrN21td3BESjk0Y0dSNmVTMmk1K0dPNTNvc043dFV5QkdKTUJhUzRYZUVVVT0KLS0tLS1FTkQgUlNBIFBSSVZBVEUgS0VZLS0tLS0K
    # API server specific configuration options.
    apiServer:
        image: registry.k8s.io/kube-apiserver:v1.30.0 # The container image used in the API server manifest.
        # Extra certificate subject alternative names for the API server's certificate.
        certSANs:
            - 127.0.0.1
        disablePodSecurityPolicy: true # Disable PodSecurityPolicy in the API server and default manifests.
        # Configure the API server admission plugins.
        admissionControl:
            - name: PodSecurity # Name is the name of the admission controller.
              # Configuration is an embedded configuration object to be used as the plugin's
              configuration:
                apiVersion: pod-security.admission.config.k8s.io/v1alpha1
                defaults:
                    audit: restricted
                    audit-version: latest
                    enforce: baseline
                    enforce-version: latest
                    warn: restricted
                    warn-version: latest
                exemptions:
                    namespaces:
                        - kube-system
                    runtimeClasses: []
                    usernames: []
                kind: PodSecurityConfiguration
        # Configure the API server audit policy.
        auditPolicy:
            apiVersion: audit.k8s.io/v1
            kind: Policy
            rules:
                - level: Metadata
    # Controller manager server specific configuration options.
    controllerManager:
        image: registry.k8s.io/kube-controller-manager:v1.30.0 # The container image used in the controller manager manifest.
    # Kube-proxy server-specific configuration options
    proxy:
        image: registry.k8s.io/kube-proxy:v1.30.0 # The container image used in the kube-proxy manifest.
        
        # # Disable kube-proxy deployment on cluster bootstrap.
        # disabled: false
    # Scheduler server specific configuration options.
    scheduler:
        image: registry.k8s.io/kube-scheduler:v1.30.0 # The container image used in the scheduler manifest.
    # Configures cluster member discovery.
    discovery:
        enabled: true # Enable the cluster membership discovery feature.
        # Configure registries used for cluster member discovery.
        registries:
            # Kubernetes registry uses Kubernetes API server to discover cluster members and stores additional information
            kubernetes:
                disabled: true # Disable Kubernetes discovery registry.
            # Service registry is using an external service to push and pull information about cluster members.
            service: {}
            # # External service endpoint.
            # endpoint: https://discovery.talos.dev/
    # Etcd specific configuration options.
    etcd:
        # The `ca` is the root certificate authority of the PKI.
        ca:
            crt: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJmakNDQVNPZ0F3SUJBZ0lRVjBRcXUzdSs2MSsrTGJ6OWw5T3YrREFLQmdncWhrak9QUVFEQWpBUE1RMHcKQ3dZRFZRUUtFd1JsZEdOa01CNFhEVEkwTURVeU16SXdOVE0wTlZvWERUTTBNRFV5TVRJd05UTTBOVm93RHpFTgpNQXNHQTFVRUNoTUVaWFJqWkRCWk1CTUdCeXFHU000OUFnRUdDQ3FHU000OUF3RUhBMElBQkNja2ZJUmJsYXdUCm1LSUNxclFvc3BoRHNPcEhrZUtkS3RkVXAyU1dFMFJuN0tyaTF6UXdzUGp2cW5GVk1uc2NtendlSCtTOFZjWE4KaEtwQVhaREpFbStqWVRCZk1BNEdBMVVkRHdFQi93UUVBd0lDaERBZEJnTlZIU1VFRmpBVUJnZ3JCZ0VGQlFjRApBUVlJS3dZQkJRVUhBd0l3RHdZRFZSMFRBUUgvQkFVd0F3RUIvekFkQmdOVkhRNEVGZ1FVVmI2bUpkdk5hdFdTCkdhRWM4eWdDYXZBSXpDNHdDZ1lJS29aSXpqMEVBd0lEU1FBd1JnSWhBSzdPSlJXOW85eGxsUzVIdUtFdHlqdE4KaW9QbHpRbklsV2JaS2xUQUdnWEZBaUVBejd0RkNaaHB5WWVxVG5xZEhLdFBpSlJjY2g5R1pBTTNkSHdUMXRxVwpiODg9Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
            key: LS0tLS1CRUdJTiBFQyBQUklWQVRFIEtFWS0tLS0tCk1IY0NBUUVFSUk1OC93MGtmOGhraXM4RDh4UHBOSm5YNEdhZ1VwMm5BR0lwMFF6VTU3NzFvQW9HQ0NxR1NNNDkKQXdFSG9VUURRZ0FFSnlSOGhGdVZyQk9Zb2dLcXRDaXltRU93NmtlUjRwMHExMVNuWkpZVFJHZnNxdUxYTkRDdworTytxY1ZVeWV4eWJQQjRmNUx4VnhjMkVxa0Jka01rU2J3PT0KLS0tLS1FTkQgRUMgUFJJVkFURSBLRVktLS0tLQo=
        
        # # The container image used to create the etcd service.
        # image: gcr.io/etcd-development/etcd:v3.5.13-arm64

        # # The `advertisedSubnets` field configures the networks to pick etcd advertised IP from.
        # advertisedSubnets:
        #     - 10.0.0.0/8
    # A list of urls that point to additional manifests.
    extraManifests: []
    #   - https://www.example.com/manifest1.yaml
    #   - https://www.example.com/manifest2.yaml

    # A list of inline Kubernetes manifests.
    inlineManifests: []
    #   - name: namespace-ci # Name of the manifest.
    #     contents: |- # Manifest contents as a string.
    #       apiVersion: v1
    #       kind: Namespace
    #       metadata:
    #       	name: ci

    
    # # A key used for the [encryption of secret data at rest](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/).

    # # Decryption secret example (do not use in production!).
    # aescbcEncryptionSecret: z01mye6j16bspJYtTB/5SFX8j7Ph4JXxM2Xuu4vsBPM=

    # # Core DNS specific configuration options.
    # coreDNS:
    #     image: registry.k8s.io/coredns/coredns:v1.11.1 # The `image` field is an override to the default coredns image.

    # # External cloud provider configuration.
    # externalCloudProvider:
    #     enabled: true # Enable external cloud provider.
    #     # A list of urls that point to additional manifests for an external cloud provider.
    #     manifests:
    #         - https://raw.githubusercontent.com/kubernetes/cloud-provider-aws/v1.20.0-alpha.0/manifests/rbac.yaml
    #         - https://raw.githubusercontent.com/kubernetes/cloud-provider-aws/v1.20.0-alpha.0/manifests/aws-cloud-controller-manager-daemonset.yaml

    # # A map of key value pairs that will be added while fetching the extraManifests.
    # extraManifestHeaders:
    #     Token: "1234567"
    #     X-ExtraInfo: info

    # # Settings for admin kubeconfig generation.
    # adminKubeconfig:
    #     certLifetime: 1h0m0s # Admin kubeconfig certificate lifetime (default is 1 year).

    # # Allows running workload on control-plane nodes.
    # allowSchedulingOnControlPlanes: true
gsaravanan@gs-macbook-pro ~ % vim controlplane.yaml 
gsaravanan@gs-macbook-pro ~ % ssh root@147.28.148.187
^C
gsaravanan@gs-macbook-pro ~ % host 147.28.148.187
187.148.28.147.in-addr.arpa domain name pointer c3-small-x86-01.
gsaravanan@gs-macbook-pro ~ % talosctl --talosconfig talosconfig config endpoint 147.28.148.187
gsaravanan@gs-macbook-pro ~ % talosctl --talosconfig talosconfig bootstrap

nodes are not set for the command: please use `--nodes` flag or configuration file to set the nodes to run the command against

Usage:
  talosctl bootstrap [flags]

Flags:
  -h, --help                      help for bootstrap
      --recover-from string       recover etcd cluster from the snapshot
      --recover-skip-hash-check   skip integrity check when recovering etcd (use when recovering from data directory copy)

Global Flags:
      --cluster string       Cluster to connect to if a proxy endpoint is used.
      --context string       Context to be used in command
  -e, --endpoints strings    override default endpoints in Talos configuration
  -n, --nodes strings        target the specified nodes
      --talosconfig string   The path to the Talos configuration file. Defaults to 'TALOSCONFIG' env variable if set, otherwise '$HOME/.talos/config' and '/var/run/secrets/talos.dev/config' in order.

gsaravanan@gs-macbook-pro ~ % talosctl --talosconfig talosconfig --nodes bootstrap

A CLI for out-of-band management of Kubernetes nodes created by Talos

Usage:
  talosctl [command]

Available Commands:
  apply-config        Apply a new configuration to a node
  bootstrap           Bootstrap the etcd cluster on the specified node.
  cluster             A collection of commands for managing local docker-based or QEMU-based clusters
  completion          Output shell completion code for the specified shell (bash, fish or zsh)
  config              Manage the client configuration file (talosconfig)
  conformance         Run conformance tests
  containers          List containers
  copy                Copy data out from the node
  dashboard           Cluster dashboard with node overview, logs and real-time metrics
  disks               Get the list of disks from /sys/block on the machine
  dmesg               Retrieve kernel logs
  edit                Edit a resource from the default editor.
  etcd                Manage etcd
  events              Stream runtime events
  gen                 Generate CAs, certificates, and private keys
  get                 Get a specific resource or list of resources (use 'talosctl get rd' to see all available resource types).
  health              Check cluster health
  help                Help about any command
  image               Manage CRI containter images
  inject              Inject Talos API resources into Kubernetes manifests
  inspect             Inspect internals of Talos
  kubeconfig          Download the admin kubeconfig from the node
  list                Retrieve a directory listing
  logs                Retrieve logs for a service
  machineconfig       Machine config related commands
  memory              Show memory usage
  meta                Write and delete keys in the META partition
  mounts              List mounts
  netstat             Show network connections and sockets
  patch               Update field(s) of a resource using a JSON patch.
  pcap                Capture the network packets from the node.
  processes           List running processes
  read                Read a file on the machine
  reboot              Reboot a node
  reset               Reset a node
  restart             Restart a process
  rollback            Rollback a node to the previous installation
  rotate-ca           Rotate cluster CAs (Talos and Kubernetes APIs).
  service             Retrieve the state of a service (or all services), control service state
  shutdown            Shutdown a node
  stats               Get container stats
  support             Dump debug information about the cluster
  time                Gets current server time
  upgrade             Upgrade Talos on the target node
  upgrade-k8s         Upgrade Kubernetes control plane in the Talos cluster.
  usage               Retrieve a disk usage
  validate            Validate config
  version             Prints the version

Flags:
      --cluster string       Cluster to connect to if a proxy endpoint is used.
      --context string       Context to be used in command
  -e, --endpoints strings    override default endpoints in Talos configuration
  -h, --help                 help for talosctl
  -n, --nodes strings        target the specified nodes
      --talosconfig string   The path to the Talos configuration file. Defaults to 'TALOSCONFIG' env variable if set, otherwise '$HOME/.talos/config' and '/var/run/secrets/talos.dev/config' in order.

Use "talosctl [command] --help" for more information about a command.
gsaravanan@gs-macbook-pro ~ % talosctl --talosconfig talosconfig --nodes bootstrap

gsaravanan@gs-macbook-pro ~ % talosctl --talosconfig talosconfig bootstrap --help 
When Talos cluster is created etcd service on control plane nodes enter the join loop waiting
to join etcd peers from other control plane nodes. One node should be picked as the boostrap node.
When boostrap command is issued, the node aborts join process and bootstraps etcd cluster as a single node cluster.
Other control plane nodes will join etcd cluster once Kubernetes is boostrapped on the bootstrap node.

This command should not be used when "init" type node are used.

Talos etcd cluster can be recovered from a known snapshot with '--recover-from=' flag.

Usage:
  talosctl bootstrap [flags]

Flags:
  -h, --help                      help for bootstrap
      --recover-from string       recover etcd cluster from the snapshot
      --recover-skip-hash-check   skip integrity check when recovering etcd (use when recovering from data directory copy)

Global Flags:
      --cluster string       Cluster to connect to if a proxy endpoint is used.
      --context string       Context to be used in command
  -e, --endpoints strings    override default endpoints in Talos configuration
  -n, --nodes strings        target the specified nodes
      --talosconfig string   The path to the Talos configuration file. Defaults to 'TALOSCONFIG' env variable if set, otherwise '$HOME/.talos/config' and '/var/run/secrets/talos.dev/config' in order.
gsaravanan@gs-macbook-pro ~ % talosctl --talosconfig talosconfig bootstrap -h    
When Talos cluster is created etcd service on control plane nodes enter the join loop waiting
to join etcd peers from other control plane nodes. One node should be picked as the boostrap node.
When boostrap command is issued, the node aborts join process and bootstraps etcd cluster as a single node cluster.
Other control plane nodes will join etcd cluster once Kubernetes is boostrapped on the bootstrap node.

This command should not be used when "init" type node are used.

Talos etcd cluster can be recovered from a known snapshot with '--recover-from=' flag.

Usage:
  talosctl bootstrap [flags]

Flags:
  -h, --help                      help for bootstrap
      --recover-from string       recover etcd cluster from the snapshot
      --recover-skip-hash-check   skip integrity check when recovering etcd (use when recovering from data directory copy)

Global Flags:
      --cluster string       Cluster to connect to if a proxy endpoint is used.
      --context string       Context to be used in command
  -e, --endpoints strings    override default endpoints in Talos configuration
  -n, --nodes strings        target the specified nodes
      --talosconfig string   The path to the Talos configuration file. Defaults to 'TALOSCONFIG' env variable if set, otherwise '$HOME/.talos/config' and '/var/run/secrets/talos.dev/config' in order.
gsaravanan@gs-macbook-pro ~ % talosctl --talosconfig talosconfig bootstrap -h