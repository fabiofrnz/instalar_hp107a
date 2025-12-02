#!/bin/bash

# Cores para facilitar a leitura
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Função para exibir cabeçalhos
print_step() {
    echo -e "\n${GREEN}=== $1 ===${NC}"
}

# Verifica se está rodando como root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Por favor, execute este script como root (sudo).${NC}"
  echo "Uso: sudo ./instalar_hp107a.sh"
  exit 1
fi

print_step "Passo 1: Removendo pacotes conflitantes (ipp-usb e sane-airscan)"
echo "Isso é necessário para que o driver da HP assuma o controle USB."
apt-get remove -y ipp-usb sane-airscan

# Verifica se a remoção foi bem-sucedida
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Pacotes removidos com sucesso.${NC}"
else
    echo -e "${YELLOW}Aviso: Falha ao remover ou pacotes não encontrados. Continuando...${NC}"
fi

print_step "Passo 2: Baixando o Driver HP (ULD)"
DRIVER_URL="https://ftp.hp.com/pub/softlib/software13/printers/CLP150/uld-hp_V1.00.39.12_00.15.tar.gz"
DRIVER_FILE="uld-hp_V1.00.39.12_00.15.tar.gz"
DIR_NAME="uld"

# Remove arquivos antigos se existirem para evitar conflito
rm -rf "$DRIVER_FILE" "$DIR_NAME"

wget -O "$DRIVER_FILE" "$DRIVER_URL"

if [ ! -f "$DRIVER_FILE" ]; then
    echo -e "${RED}Erro: Falha ao baixar o driver. Verifique sua conexão.${NC}"
    exit 1
fi

print_step "Passo 3: Extraindo e Instalando"
tar -xvf "$DRIVER_FILE"

if [ -d "$DIR_NAME" ]; then
    cd "$DIR_NAME"
    
    echo -e "${YELLOW}ATENÇÃO: O instalador da HP irá iniciar agora.${NC}"
    echo -e "${YELLOW}1. Pressione ENTER para ler o contrato (pressione 'q' para pular a leitura se desejar).${NC}"
    echo -e "${YELLOW}2. Digite 'y' e dê Enter para aceitar os termos.${NC}"
    echo -e "${YELLOW}3. Confirme as instalações padrão.${NC}"
    echo "Iniciando em 3 segundos..."
    sleep 3
    
    # Executa o script oficial da HP
    ./install.sh
    
    cd ..
else
    echo -e "${RED}Erro: Diretório 'uld' não encontrado após extração.${NC}"
    exit 1
fi

print_step "Passo 4: Limpeza e Finalização"
# Reiniciando o serviço de impressão para garantir que as mudanças tenham efeito
systemctl restart cups
echo "Serviço CUPS reiniciado."

# Limpeza dos arquivos baixados
rm -rf "$DRIVER_FILE" "$DIR_NAME"
echo "Arquivos de instalação temporários removidos."

echo -e "\n${GREEN}=== CONCLUÍDO ===${NC}"
echo -e "${YELLOW}Instruções Finais:${NC}"
echo "1. Conecte sua impressora HP 107a via USB (se já não estiver)."
echo "2. Vá em Menu > Configurações > Impressoras."
echo "3. Clique em 'Adicionar' (+)."
echo "4. Ao selecionar a impressora, certifique-se de escolher o driver:"
echo -e "   ${GREEN}HP Laser 10x Series${NC}"
echo "5. Se não aparecer automaticamente, escolha 'Selecionar do banco de dados' > 'Hewlett-Packard' > 'HP Laser 10x Series'."
echo -e "\Recomendação: Reinicie o computador se a impressora não for detectada imediatamente."
