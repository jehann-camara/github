"""
SCRIPT 47: AZURE IOT HUBS DADOS
Nível: Básico-Intermediário
Foco: Ingestão de dados de dispositivos IoT
"""

class IoTHubsDados:
    def __init__(self):
        self.diferencas_iot_vs_event_hubs = {
            "IoT Hub": "Otimizado para dispositivos IoT com gerenciamento",
            "Event Hubs": "Otimizado para ingestao de eventos generica",
            "Protocolos": "IoT Hub suporta MQTT, AMQP, HTTPS",
            "Dispositivos": "IoT Hub gerencia identidade de dispositivos",
            "Comandos": "IoT Hub permite enviar comandos para dispositivos"
        }
    
    def criar_configuracao_iot_hub(self, nome_iot_hub):
        config = {
            "nome": nome_iot_hub,
            "sku": "S1 - Standard",
            "units": 1,
            "retention": 7,
            "endpoints": {
                "events": "Event Hub-compatible endpoint",
                "messages": "Cloud-to-device messages",
                "file_upload": "File upload storage"
            }
        }
        return config
    
    def fluxo_dados_iot(self):
        fluxo = [
            "1. Dispositivo envia telemetria via MQTT/AMQP",
            "2. IoT Hub recebe e autentica dispositivo",
            "3. Dados sao roteados para processamento",
            "4. Stream Analytics processa telemetria",
            "5. Resultados sao enviados para Power BI/Data Lake"
        ]
        return fluxo
    
    def tipos_telemetria_iot(self):
        tipos = [
            "Dados de sensores (temperatura, umidade)",
            "Localizacao GPS",
            "Status de equipamentos",
            "Metricas de performance",
            "Alertas e notificacoes"
        ]
        return tipos

def demonstrar_iot_hubs():
    iot_hubs = IoTHubsDados()
    
    print("=== AZURE IOT HUBS DADOS ===")
    print("Diferencas IoT Hub vs Event Hubs:")
    for servico, diferenca in iot_hubs.diferencas_iot_vs_event_hubs.items():
        print(f"- {servico}: {diferenca}")
    
    print("\nConfiguracao IoT Hub Exemplo:")
    config = iot_hubs.criar_configuracao_iot_hub("iot-hub-fabrica")
    for chave, valor in config.items():
        print(f"{chave}: {valor}")
    
    print("\nFluxo de Dados IoT:")
    for etapa in iot_hubs.fluxo_dados_iot():
        print(f"{etapa}")
    
    print("\nTipos de Telemetria IoT:")
    for tipo in iot_hubs.tipos_telemetria_iot():
        print(f"- {tipo}")

if __name__ == "__main__":
    demonstrar_iot_hubs()