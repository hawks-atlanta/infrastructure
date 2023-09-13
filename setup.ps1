$ProgressPreference = 'SilentlyContinue'

if (!(Test-Path -Path bin)) {
    mkdir bin
}

if (!("$ENV:PATH".Contains("$(pwd)"))) {
    echo "[*] Setting path"
    $ENV:PATH="$ENV:PATH;$(pwd)/bin"
}

if (!(where.exe kubectl) -and !(Test-Path -Path "bin/kubectl.exe")) {
    echo "[*] Downloading kubectl"
    wget -o "bin/kubectl.exe" "https://dl.k8s.io/release/v1.27.3/bin/windows/amd64/kubectl.exe"
}

if (!(where.exe helm) -and !(Test-Path -Path "bin/helm.exe")) {
    echo "[*] Downloading helm"
    wget -o "bin/helm.zip" "https://get.helm.sh/helm-v3.12.1-windows-amd64.zip"
    echo "[*] Unzip helm"
    Expand-Archive bin/helm.zip -DestinationPath bin/
    mv bin/windows-amd64/helm.exe bin/helm.exe
    rm -Recurse -Force bin/windows-amd64
    rm -Force bin/helm.zip
}

if (!(where.exe terraform)) {
    echo "[*] Downloading terraform"
    wget -o bin/terraform.zip "https://releases.hashicorp.com/terraform/1.5.2/terraform_1.5.2_windows_amd64.zip"
    Expand-Archive bin/terraform.zip -DestinationPath bin/
    rm -Force bin/terraform.zip
}

if ((Test-Path -Path "k3s.yaml") -and ($ENV:KUBECONFIG -ne "$(pwd)/k3s.yaml")) {
    echo "[*] Setting KUBECONFIG"
    $ENV:KUBECONFIG = "$(pwd)/k3s.yaml"
}