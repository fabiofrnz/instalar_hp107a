Script de Instalação Automática - Driver HP Laser 107a (Linux Mint/Ubuntu)

Este repositório contém um script em Shell (.sh) desenvolvido para automatizar a instalação do driver HP Laser 10x Series para a impressora HP Laser 107a em distribuições baseadas no Debian (Linux Mint, Ubuntu, etc.).

O script soluciona o problema comum de não reconhecimento da impressora ou uso de drivers genéricos incorretos, removendo pacotes de impressão "driverless" que geram conflito e instalando o driver proprietário ULD (Unified Linux Driver) da HP.

Funcionalidades

O script instalar_hp107a.sh executa as seguintes tarefas sequencialmente:

Verificação de Privilégios: Garante que o script seja executado como superusuário (root).

Remoção de Conflitos: Remove os pacotes ipp-usb e sane-airscan, que frequentemente impedem o funcionamento do driver USB proprietário da HP em versões mais recentes do Linux Mint (21.x+) e Ubuntu.

Download Automático: Baixa a versão específica do driver (V1.00.39.12_00.15) diretamente dos servidores FTP da HP.

Extração e Execução: Descompacta o arquivo .tar.gz e inicia o instalador oficial da HP.

Limpeza: Reinicia o serviço CUPS e remove os arquivos temporários de instalação.

Como Usar

Abra o terminal e execute os seguintes comandos:

# 1. Dê permissão de execução ao arquivo
chmod +x instalar_hp107a.sh

# 2. Execute o script como root
sudo ./instalar_hp107a.sh


Durante a execução:

O instalador oficial da HP será aberto no terminal.

Pressione q para pular o contrato de licença (ou Enter para ler).

Digite y para aceitar os termos.

Pós-Instalação

Após a execução do script:

Acesse as Configurações de Impressora do sistema.

Adicione uma nova impressora.

Selecione a HP Laser 107a.

Certifique-se de selecionar o driver "HP Laser 10x Series" (se não for automático, busque em Hewlett-Packard na lista de drivers).

Requisitos

Linux Mint 21.x, Ubuntu 20.04+ ou derivados.

Conexão com a internet (para baixar o driver via wget).

Privilégios de superusuário (sudo).

Nota: Este é um script de automação comunitário e baixa drivers oficiais da HP. Não possui vínculo direto com a Hewlett-Packard.
