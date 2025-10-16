
## Introdução
    Nas últimas décadas, a quantidade de dados gerados por sistemas, aplicativos e dispositivos aumentou significativamente. Os dados estão em todos os lugares, em uma infinidade de estruturas e formatos.

    Agora é mais fácil coletar dados e mais barato armazená-los, o que torna os dados acessíveis para quase todas as empresas. As soluções de dados incluem tecnologias de software e plataformas que podem ajudar a facilitar a coleta, a análise e o armazenamento de informações valiosas. Toda empresa gostaria de aumentar suas receitas e gerar maiores lucros. Nesse mercado competitivo, os dados são ativos valiosos. Quando analisados corretamente, os dados fornecem uma abundância de informações úteis e fundamentam decisões comerciais críticas.

    A capacidade de capturar, armazenar e analisar dados é um requisito fundamental para todas as organizações do mundo. Neste módulo, você aprenderá sobre as opções para representar e armazenar dados e aprenderá sobre cargas de trabalho de dados típicas. Ao concluir este módulo, você criará a base para aprender sobre as técnicas e os serviços usados para trabalhar com os dados.

## Identificar formatos de dados
    Os dados são uma coleção de fatos, como números, descrições e observações usados para registrar informações. As estruturas de dados nas quais esses dados são organizados geralmente representam entidades que são importantes para uma organização (como clientes, produtos, ordens de venda etc.). Normalmente, cada entidade tem um ou mais atributos ou características (por exemplo, um cliente pode ter um nome, um endereço, um número de telefone e assim por diante).

    Podemos classificar os dados como estruturados, semiestruturados ou não estruturados.

## Dados estruturados
    Dados estruturados obedecem a um esquema fixo, portanto, todos os dados têm os mesmos campos ou propriedades. Normalmente, o esquema para entidades de dados estruturados é tabular. Em outras palavras, os dados são representados em uma ou mais tabelas que consistem em linhas para representar cada instância de uma entidade de dados e colunas para representar os atributos da entidade. Por exemplo, a imagem a seguir mostra representações de dados tabulares para as entidades Customer e Product.

    Os dados estruturados geralmente são armazenados em um banco de dados no qual várias tabelas podem referenciar umas às outras usando valores de chave em um modelo relacional, o qual exploraremos mais detalhadamente adiante.

## Dados semiestruturados
    Dados semiestruturados são informações que têm alguma estrutura, mas que permitem alguma variação entre instâncias da entidade. Por exemplo, embora a maioria dos clientes possa ter um endereço de email, alguns podem ter vários endereços de email e outros podem não ter nenhum.

    Um formato comum para dados semiestruturados é o JSON (JavaScript Object Notation). O exemplo a seguir mostra um par de documentos JSON que representam informações do cliente. Cada documento do cliente inclui informações de endereço e de contato, mas os campos específicos variam entre os clientes.

        // Customer 1
        {
          "firstName": "Joe",
          "lastName": "Jones",
          "address":
          {
            "streetAddress": "1 Main St.",
            "city": "New York",
            "state": "NY",
           "postalCode": "10099"
          },
          "contact":
          [
            {
             "type": "home",
             "number": "555 123-1234"
            },
            {
              "type": "email",
              "address": "joe@litware.com"
            }
          ]
        }

        // Customer 2
        {
          "firstName": "Samir",
          "lastName": "Nadoy",
          "address":
          {
            "streetAddress": "123 Elm Pl.",
            "unit": "500",
            "city": "Seattle",
            "state": "WA",
            "postalCode": "98999"
          },
          "contact":
          [
            {
              "type": "email",
              "address": "samir@northwind.com"
            }
          ]
        }    

## Dados não estruturados
Nem todos os dados são estruturados ou até mesmo semiestruturados. Por exemplo, documentos, imagens, dados de áudio e vídeo e arquivos binários podem não ter uma estrutura específica. Esse tipo de dados é conhecido como dados não estruturados.

## Armazenamentos de dados
    As organizações normalmente armazenam dados em formato estruturado, semiestruturado ou não estruturado para registrar detalhes de entidades (por exemplo, clientes e produtos), eventos específicos (como transações de vendas) ou outras informações em documentos, imagens e outros formatos. Os dados armazenados podem ser recuperados para análise e relatórios posteriormente.

    Há duas categorias amplas de armazenamento de dados comuns em uso:

    Armazenamentos de arquivos
    Bancos de dados
    Exploraremos esses dois tipos de armazenamento de dados nos tópicos subsequentes.


## Explorar o armazenamento de arquivos
    A capacidade de armazenar dados em arquivos é um elemento básico de qualquer sistema computacional. Os arquivos podem ser armazenados em sistemas de arquivos locais no disco rígido do seu PC e em mídia removível, como unidades USB. Mas, na maioria das organizações, arquivos de dados importantes são armazenados de maneira centralizada em algum tipo de sistema de armazenamento de arquivos compartilhado. Cada vez mais, esse local de armazenamento central está sendo hospedado na nuvem, possibilitando um armazenamento econômico, seguro e confiável para grandes volumes de dados.

    O formato de arquivo específico usado para armazenar dados depende de vários fatores, incluindo:

    O tipo de dados que está sendo armazenado (estruturado, semiestruturado ou não estruturado).
    Os aplicativos e serviços que precisarão ler, gravar e processar os dados.
    A necessidade de que os arquivos de dados sejam legíveis por seres humanos ou otimizados para armazenamento e processamento eficientes.
    Alguns formatos de arquivo comuns são discutidos abaixo.

## Arquivos de texto delimitados
    Geralmente, os dados são armazenados em formato de texto sem formatação com delimitadores de campo e terminadores de linha específicos. O formato mais comum para dados delimitados é CSV (valores separados por vírgula) nos quais os campos são separados por vírgulas e as linhas terminam com um retorno de carro/nova linha. Opcionalmente, a primeira linha pode incluir os nomes de campo. Outros formatos comuns incluem TSV (valores separados por tabulação) e delimitado por espaço (em que as tabulações ou os espaços são usados para separar campos) e dados de largura fixa em que a cada campo é alocado um número fixo de caracteres. O texto delimitado é uma boa opção para dados estruturados que precisam ser acessados por uma ampla variedade de aplicativos e serviços em um formato legível.

    O seguinte exemplo mostra dados de clientes em formato delimitado por vírgulas:

    FirstName,LastName,Email
    Joe,Jones,joe@litware.com
    Samir,Nadoy,samir@northwind.com

## JavaScript Object Notation (JSON)
    O JSON é um formato onipresente no qual um esquema de documento hierárquico é usado para definir entidades de dados (objetos) que têm vários atributos. Cada atributo pode ser um objeto (ou uma coleção de objetos), tornando o JSON um formato flexível que é bom para dados estruturados e semiestruturados.

    O exemplo a seguir mostra um documento JSON que contém uma coleção de clientes. Cada cliente tem três atributos (firstName, lastName e contato) e o atributo de contato contém uma coleção de objetos que representam um ou mais métodos de contato (email ou telefone). Observe que os objetos estão entre chaves ({..}) e as coleções estão entre colchetes ([..]). Os atributos são representados por pares name:value e separados por vírgulas (,).

        // Customer 1
        {
          "firstName": "Joe",
          "lastName": "Jones",
          "address":
          {
            "streetAddress": "1 Main St.",
            "city": "New York",
            "state": "NY",
           "postalCode": "10099"
          },
          "contact":
          [
            {
             "type": "home",
             "number": "555 123-1234"
            },
            {
              "type": "email",
              "address": "joe@litware.com"
            }
          ]
        }

        // Customer 2
        {
          "firstName": "Samir",
          "lastName": "Nadoy",
          "address":
          {
            "streetAddress": "123 Elm Pl.",
            "unit": "500",
            "city": "Seattle",
            "state": "WA",
            "postalCode": "98999"
          },
          "contact":
          [
            {
              "type": "email",
              "address": "samir@northwind.com"
            }
          ]
        }

## Linguagem XML (Extensible Markup Language)
    O XML é um formato de dados legível que foi popular nos anos 90 e 2000. Ele tem sido amplamente substituído pelo formato JSON que é menos detalhado, mas ainda há alguns sistemas que usam XML para representar dados. O XML usa marcas entre colchetes angulares (<.. />) para definir elementos e atributos, conforme mostrado neste exemplo:
<Customers>
  <Customer name="Joe" lastName="Jones">
    <ContactDetails>
      <Contact type="home" number="555 123-1234"/>
      <Contact type="email" address="joe@litware.com"/>
    </ContactDetails>
  </Customer>
  <Customer name="Samir" lastName="Nadoy">
    <ContactDetails>
      <Contact type="email" address="samir@northwind.com"/>
    </ContactDetails>
  </Customer>
</Customers>

## BLOB (objeto binário grande)
    Em última análise, todos os arquivos são armazenados como dados binários (1 e 0), mas nos formatos legíveis descritos acima, os bytes de dados binários são mapeados em caracteres imprimíveis (normalmente por um esquema de codificação de caracteres, como ASCII ou Unicode). No entanto, alguns formatos de arquivo, particularmente para dados não estruturados, armazenam os dados como binários brutos que devem ser interpretados por aplicativos e renderizados. Os tipos comuns de dados armazenados como binários incluem imagens, vídeo, áudio e documentos específicos de aplicativos.

    Ao trabalhar com dados como esse, os profissionais de dados geralmente se referem aos arquivos de dados como BLOBs (Objetos Binários Grandes).

## Formatos de arquivo otimizados
    Embora os formatos legíveis para dados estruturados e semiestruturados possam ser úteis, normalmente eles não são otimizados para espaço de armazenamento ou processamento. Ao longo do tempo, alguns formatos de arquivo especializados que permitem a compactação, a indexação e o armazenamento e o processamento eficientes foram desenvolvidos.

    lguns formatos de arquivo otimizados comuns que você pode ver incluem Avro, ORC e Parquet:

    Avro é um formato baseado em linha. Ele foi criado pelo Apache. Cada registro contém um cabeçalho que descreve a estrutura dos dados no registro. Esse cabeçalho é armazenado como JSON. Os dados são armazenados como informações binárias. Um aplicativo usa as informações no cabeçalho para analisar os dados binários e extrair os campos contidos neles. O Avro é um formato bom para compactar dados e minimizar os requisitos de armazenamento e largura de banda de rede.

    ORC (formato Columnar de Linha Otimizada) organiza dados em colunas em vez de linhas. Ele foi desenvolvido pela HortonWorks para otimizar as operações de leitura e gravação no Apache Hive (o Hive é um sistema de data warehouse que dá suporte a resumos rápidos de dados e consultas em grandes conjuntos de dados). Um arquivo ORC contém faixas de dados. Cada faixa contém os dados de uma coluna ou conjunto de colunas. Uma faixa contém um índice nas linhas na faixa, os dados de cada linha e um rodapé que contém informações estatísticas (contagem, soma, máximo, mínimo e assim por diante) para cada coluna.

    Parquet é outro formato de dados columnar. Ele foi criado pelo Cloudera e X. Um arquivo Parquet contém grupos de linhas. Os dados de cada coluna são armazenados juntos no mesmo grupo de linhas. Cada grupo de linhas contém uma ou mais partes de dados. Um arquivo Parquet inclui metadados que descrevem o conjunto de linhas encontrado em cada parte. Um aplicativo pode usar esses metadados para localizar rapidamente a parte correta de um determinado conjunto de linhas e recuperar os dados nas colunas especificadas para essas linhas. O Parquet é especialista em armazenar e processar tipos de dados aninhados com eficiência. Ele dá suporte a esquemas de codificação e compactação muito eficientes.

## Explorar bancos de dados
    Um banco de dados é usado para definir um sistema central no qual dados podem ser armazenados e consultados. De maneira simplista, o sistema de arquivos no qual os arquivos são armazenados é um tipo de banco de dados; mas quando usamos o termo em um contexto de dados profissional, normalmente nos referimos a um sistema dedicado para gerenciar registros de dados em vez de arquivos.   

## Bancos de dados relacionais
    Os bancos de dados relacionais são comumente usados para armazenar e consultar dados estruturados. Os dados são armazenados em tabelas que representam entidades, como clientes, produtos ou pedidos de venda. Cada instância de uma entidade recebe uma chave primária que a identifica de maneira exclusiva. Essas chaves são usadas para fazer referência à instância da entidade em outras tabelas. Por exemplo, a chave primária de um cliente pode ser referenciada em um registro de pedido de venda para indicar qual cliente fez o pedido. Esse uso de chaves para referenciar entidades de dados permite que um banco de dados relacional seja normalizado, o que, em parte, significa a eliminação de valores de dados duplicados para que, por exemplo, os detalhes de um cliente individual sejam armazenados apenas uma vez e não para cada pedido de vendas que o cliente faz. As tabelas são gerenciadas e consultadas usando a linguagem SQL, que se baseia em um padrão ANSI e que, portanto, é semelhante entre vários sistemas de banco de dados. 

## Bancos de dados não relacionais
    Os bancos de dados não relacionais são sistemas de gerenciamento de dados que não aplicam um esquema relacional aos dados. Os bancos de dados não relacionais geralmente são chamados de banco de dados NoSQL, embora alguns ofereçam suporte a uma variante da linguagem SQL.

    Há quatro tipos comuns de banco de dados não relacionais normalmente em uso.

    Bancos de dados de chave-valor nos quais cada registro consiste em uma chave exclusiva e um valor associado, que pode estar em qualquer formato.

    Bancos de dados de documentos, que são uma forma específica de banco de dados de chave-valor na qual o valor é um documento JSON (em que o sistema é otimizado para análise e consulta)

    Bancos de dados de família de colunas que podem armazenar dados tabulares que abrangem linhas e colunas; você também pode dividir as colunas em grupos conhecidos como famílias de colunas. Cada família de colunas contém um conjunto de colunas que estão logicamente relacionadas.

    Bancos de dados de grafo, que armazenam entidades como nós com links para definir relações entre eles.

## Explorar o processamento de dados transacionais
    Um sistema de processamento de dados transacionais é o que a maioria das pessoas considera a principal função da computação empresarial. Um sistema transacional registra transações que encapsulam eventos específicos que a organização deseja controlar. Uma transação pode ser financeira, como a movimentação de dinheiro entre contas em um sistema bancário, ou pode fazer parte de um sistema de varejo, controlando pagamentos de bens e serviços de clientes. Pense na transação como uma unidade de trabalho pequena e discreta.

    Os sistemas transacionais geralmente são de alto volume, às vezes manipulando muitos milhões de transações em um dia. Os dados que estão sendo processados têm que estar acessíveis com rapidez. O trabalho executado por sistemas transacionais é geralmente conhecido como OLTP (Processamento de Transações Online).

    As soluções OLTP dependem de um sistema de banco de dados no qual o armazenamento de dados é otimizado para operações de leitura e gravação para dar suporte a cargas de trabalho transacionais nas quais os registros de dados são criados, recuperados, atualizados e excluídos (essas operações são geralmente chamadas de CRUD). Essas operações são aplicadas de maneira transacional para garantir a integridade dos dados armazenados no banco de dados. Para fazer isso, os sistemas OLTP impõem transações compatíveis com a semântica conhecida como ACID:

## ACID:
    Atomicidade – cada transação é tratada como uma única unidade, que é totalmente bem-sucedida ou que falha completamente. Por exemplo, uma transação que envolve o débito de fundos de uma conta e o crédito do mesmo valor em outra conta deve concluir ambas as ações. Se uma das ações não puder ser concluída, a outra ação deverá falhar.

    Consistência – as transações só podem conduzir os dados do banco de dados de um estado válido para outro estado válido. Para continuar com o exemplo de débito e crédito acima, o estado concluído da transação deve refletir na transferência de fundos de uma conta para outra.

    Isolamento – as transações simultâneas não podem interferir entre si e devem resultar em um estado consistente do banco de dados. Por exemplo, enquanto a transação para transferir fundos de uma conta para outra está em processo, outra transação que verifica o saldo dessas contas deve retornar resultados consistentes – a transação de verificação de saldo não pode recuperar um valor para uma conta que reflita o saldo antes da transferência e um valor para a outra conta que reflita o saldo após a transferência.

    Durabilidade – quando uma transação tiver sido confirmada, ela permanecerá confirmada. Depois que a transação de transferência entre contas for concluída, os saldos de conta revisados serão persistidos para que, mesmo que o sistema do banco de dados seja desligado, a transação confirmada seja refletida quando ele for ligado novamente.

    Os sistemas OLTP normalmente são usados para dar suporte a aplicativos dinâmicos que processam dados de negócios, geralmente chamados de aplicativos de LOB (linha de negócios).

## OLTP : (Processamento de Transações Online).
## CRUD : CREATE - READ - UPDATE - DELETE.

## Explorar o processamento de dados analíticos
    O processamento de dados analíticos normalmente usa sistemas somente leitura (ou read-mostly) que armazenam grandes volumes de dados históricos ou métricas de negócios. A análise pode ser baseada em um instantâneo dos dados em um determinado momento ou em uma série de instantâneos.

    Os detalhes específicos de um sistema de processamento analítico podem variar entre as soluções, mas uma arquitetura comum de análise de escala empresarial tem esta aparência:

    Os dados operacionais são extraídos, transformados e carregados (ETL) em um data lake para análise.

    Os dados são carregados em um esquema de tabelas – normalmente em um data lakehouse baseado em Spark com abstrações tabulares em arquivos no data lake ou em um data warehouse com um mecanismo SQL totalmente relacional.

    Os dados no data warehouse podem ser agregados e carregados em um modelo OLAP (processamento analítico online) ou cubo. Valores numéricos agregados (medidas) de tabelas de fatos são calculados para interseções de dimensões da tabelas de dimensões. Por exemplo, a receita de vendas pode ser totalizada por data, cliente e produto.

    Os dados no data lake, no data warehouse e no modelo analítico podem ser consultados para produzir relatórios, visualizações e painéis.

## ETL = Extract, Transform, Load : (Extrair, Transformar, Carregar)
    É o processo fundamental de movimentação e preparação de dados que todo Engenheiro de Dados domina.
    Transforma dados brutos em informação útil
    Padroniza dados de fontes diferentes
    Prepara dados para análise/BI
    Garante qualidade dos dados

## Data lakes são comuns em cenários de processamento analítico de dados em grande escala, em que um grande volume de dados baseados em arquivo precisa ser coletado e analisado.

## Data warehouses são uma forma estabelecida de armazenar dados em um esquema relacional otimizado para operações de leitura – principalmente consultas para dar suporte a relatórios e à visualização de dados. 

## Os Data Lakehouses são uma inovação mais recente que combina o armazenamento flexível e escalonável de um data lake com a semântica de consulta relacional de um data warehouse. O esquema de tabela pode exigir alguma desnormalização de dados em uma fonte de dados OLTP (apresentando algumas duplicações para fazer com que as consultas sejam executadas mais rapidamente).

## Resumo Rápido - Data warehouses - Data Lake - Data Lakehouses :

    Data Warehouse (Armazém de Dados): Como um shopping center organizado.

      Dados estruturados e tratados
      Para relatórios e BI
      Schema rígido (pré-definido)

    Data Lake (Lago de Dados): Como um terreno baldio para armazenar tudo.

      Dados brutos (estruturados, semi e não estruturados)
      Para exploração futura (Data Science, ML(Machine Learning: Aprendizado de Máquina))
      Schema flexível (definido na leitura)
    
    Funções do Engenheiro de Dados:
    Você vai coletar dados para o Lake e preparar dados do Lake para o Warehouse. É o ciclo básico dos dados!
    Seu papel será coletar, limpar e preparar esses dados para os Cientistas de Dados usarem nos modelos de ML( Machine Learning)

    Data Lakehouse (Armazém Moderno): É como um armazém inteligente que combina o melhor dos dois. Você tem a flexibilidade de jogar tudo (como no lago) mas também a organização do supermercado. Além disso, tem esteiras robóticas (ferramentas) que ajudam a organizar e acessar os dados rapidamente.
        O Data Lakehouse surgiu para unir:
        A flexibilidade e custo do Data Lake
        A gestão de dados e performance do Data Warehouse

## Um modelo OLAP é um tipo agregado de armazenamento de dados que é otimizado para cargas de trabalho analíticas. 
    As agregações de dados são feitas entre dimensões em diferentes níveis, permitindo que você faça drill up/down para exibir agregações em vários níveis hierárquicos; por exemplo, para localizar o total de vendas por região, por cidade ou por um endereço individual. Como os dados do OLAP são previamente agregados, as consultas para retornar os resumos que ele contém podem ser executadas rapidamente.

## Tipos diferentes de usuários podem executar trabalhos de análise de dados em diferentes estágios da arquitetura geral. Por exemplo:
    Os cientistas de dados podem trabalhar diretamente com arquivos de dados em um data lake para explorar e modelar os dados.
    Os Analistas de Dados podem consultar tabelas diretamente no data warehouse para produzir relatórios e visualizações complexos.
    Os usuários empresariais podem consumir dados previamente agregados em um modelo analítico na forma de relatórios ou painéis.


## Explorar cargos de trabalho no mundo dos dados

  Há uma ampla variedade de funções que envolvem gerenciamento, controle e uso de dados. Algumas funções são orientadas aos negócios, outras envolvem mais engenharia e as demais focam na pesquisa, já outras são funções híbridas que combinam diferentes aspectos de gerenciamento de dados. Sua organização poderá definir funções de modo diferente ou dar a elas outros nomes, porém as funções descritas nesta unidade incluem a divisão mais comum de tarefas e responsabilidades.

  As três funções de trabalho importantes que lidam com os dados na maioria das organizações são:

  Administradores de Banco de Dados, que gerenciam bancos de dados, atribuindo permissões aos usuários, armazenando cópias de backup de dados e restaurando dados em caso de falhas.

  Engenheiros de dados, que gerenciam a infraestrutura e os processos de integração de dados em toda a organização, aplicando rotinas de limpeza de dados, identificando regras de governança de dados e implementando pipelines para transferir e transformar dados entre sistemas.

  Analistas de Dados, que exploram e analisam dados para criar visualizações e gráficos que permitem que as organizações tomem decisões informadas.

## Administradores de Banco de Dados
    Um administrador de banco de dados é responsável pelos aspectos de design, de implementação, de manutenção e de operação dos sistemas de bancos de dados locais e baseados em nuvem. Eles são responsáveis pela disponibilidade geral e pelo desempenho e otimizações consistentes dos bancos de dados. Eles trabalham com os stakeholders para implementar políticas e ferramentas, além de processos de backup e planos de recuperação para serem usados após um desastre natural ou erro humano.

O Administrador de Banco de Dados também é responsável por gerenciar a segurança dos dados nos bancos de dados, conceder privilégios sobre os dados, além de conceder ou negar acesso aos usuários conforme apropriado.

## Engenheiros de Dados
     Os engenheiros de dados colaboram com os stakeholders para projetar e implementar cargas de trabalho relacionadas a dados, incluindo pipelines de ingestão de dados, atividades de limpeza e transformação e armazenamentos de dados para cargas de trabalho analíticas. Eles usam uma ampla variedade de tecnologias de plataforma de dados, incluindo bancos de dados relacionais e não relacionais, repositórios de arquivos e fluxos de dados.

    Eles também são responsáveis por garantir que a privacidade dos dados seja mantida dentro da nuvem, abrangendo armazenamentos de dados locais e na nuvem. Eles são responsáveis por gerenciar e monitorar pipelines de dados para garantir que as cargas de dados tenham o desempenho esperado.

## Analista de Dados    
    Um analista de dados permite que as empresas maximizem o valor dos ativos de dados. Eles são responsáveis por explorar dados para identificar tendências e relações, projetar e criar modelos analíticos e favorecer capacidades avançadas de análise por meio de relatórios e visualizações.

    m Analista de Dados processa dados brutos e, com base em requisitos empresariais identificados, os transforma para fornecer insights relevantes.       

## Identificar serviços de dados
    O Microsoft Azure é uma plataforma de nuvem que potencializa os aplicativos e a infraestrutura de TI de algumas das maiores organizações do mundo. Ele inclui muitos serviços para dar suporte a soluções de nuvem, incluindo cargas de trabalho de dados transacionais e analíticas.

    Alguns dos serviços de nuvem mais usados para dados estão descritos abaixo.

    SQL do Azure é o nome coletivo de uma família de soluções de banco de dados relacional com base no mecanismo de banco de dados do Microsoft SQL Server. Os serviços específicos de SQL do Azure incluem:

    Banco de Dados SQL do Azure – um banco de dados de plataforma como serviço (PaaS) totalmente gerenciado e hospedado no Azure.
    Instância Gerenciada de SQL do Azure – uma instância hospedada do SQL Server com manutenção automatizada, que permite uma configuração mais flexível do que o BD de SQL do Azure, mas com mais responsabilidade administrativa para o proprietário.

    VM de SQL do Azure – uma máquina virtual com uma instalação do SQL Server, permitindo a máxima capacidade de configuração com total responsabilidade de gerenciamento.
    Os administradores de banco de dados normalmente provisionam e gerenciam os sistemas de banco de dados SQL do Azure para dar suporte a aplicativos de LOB (linha de negócios) que precisam armazenar dados transacionais.

    Os engenheiros de dados podem usar os sistemas de banco de dados SQL do Azure como fontes para (pipelines de dados) que executam operações de ETL (extração, transformação e carregamento) para ingerir os dados transacionais em um sistema analítico.

    Os analistas de dados podem consultar os bancos de dados SQL do Azure diretamente para criar relatórios, no entanto, em grandes organizações, os dados geralmente são combinados com os dados de outras fontes em um armazenamento de dados analíticos para dar suporte às análises empresariais.

## Cargas de Trabalho Transacionais (OLTP: Online Transactional Processing)
    São sistemas otimizados para operações do dia a dia, como inserir, atualizar, excluir e consultar pequenos volumes de dados de forma rápida.

    Exemplos: caixa de supermercado, sistema bancário, reservas de hotel.

    Características: transações ACID, baixa latência, alta concorrência, normalização.
    
    TRANSACIONAL = "FAZER"
    Foco: Operação
    Pergunta: "O que está acontecendo AGORA?"
    Exemplo: Vender um produto

## Cargas de Trabalho Analíticas (OLAP: Online Analytical Processing)
    São sistemas otimizados para análise e relatórios, envolvendo grandes volumes de dados e consultas complexas.

    Exemplos: relatório de vendas por região, análise de tendências, business intelligence.

    Características: leituras intensivas, agregações, desnormalização, data warehouses.
    
    ANALÍTICO = "ENTENDER"
    Foco: Insight
    Pergunta: "O que aconteceu e por quê?"
    Exemplo: Analisar vendas do trimestre

# TYPICAL DATA PIPELINE:

## ARCHITECTURE FLOW
OLTP SYSTEMS → ETL/ELT PROCESS → OLAP SYSTEMS
    ↓                            ↓
Operational Data              Analytical Data
(Current, Detailed)           (Historical, Aggregated)

## Pipelines de dados 
    Um pipeline de dados é uma série de processos que move dados de uma fonte para um destino, aplicando transformações no caminho.

## Padrões Comuns de Pipelines:

1. ETL (Extract, Transform, Load)
Ordem: Extrair → Transformar → Carregar
Uso: Dados estruturados, data warehouses
Ferramentas: Azure Data Factory, SQL Server Integration Services

## **FLUXO ETL:**
Fonte → Extração → Transformação (em servidor) → Carga → Data Warehouse

2. ELT (Extract, Load, Transform)
Ordem: Extrair → Carregar → Transformar

Uso: Big Data, data lakes

Ferramentas: Azure Databricks, Spark

## **FLUXO ELT:**
Fonte → Extração → Carga (no data lake) → Transformação → Análise

## FLUXO DETALHADO - EXEMPLO PRÁTICO
Cenário: Relatório de Vendas Diário

## **PIPELINE COMPLETO:**

1. 🗃️  FONTES
   ├── Vendas (banco de dados)
   ├── Clientes (API)
   └── Produtos (arquivo CSV)

2. ⚡ EXTRAÇÃO (Azure Data Factory)
   ├── Consulta SQL: SELECT * FROM vendas WHERE data = TODAY
   ├── Chamada API: GET /clientes
   └── Leitura CSV: produtos.csv

3. 🛠️  TRANSFORMAÇÃO (Azure Databricks)
   ├── Limpeza: remove vendas canceladas
   ├── Join: vendas + clientes + produtos
   ├── Cálculo: totais, médias, métricas
   └── Validação: qualidade dos dados

4. 💾 CARGA (Azure Synapse Analytics)
   ├── Tabela: fat_vendas_diarias
   ├── Tabela: dim_clientes
   └── Tabela: dim_produtos

5. 📈 CONSUMO (Power BI)
   ├── Dashboard: vendas do dia
   ├── Relatório: performance por região
   └── Alertas: metas não atingidas

## **Pipeline batch ETL:**
    Azure SQL (fonte) → ADF (extração) → Data Lake (raw) → 
    Databricks (transformação) → Data Lake (processed) → 
    Azure SQL (destino) → Power BI (consumo)

## Bancos de dados de software de código aberto no Azure
- Banco de Dados do Azure para MySQL – um sistema de gerenciamento de banco de dados de código aberto fácil de usar que é comumente usado em aplicativos da pilha LAMP (Linux, Apache, MySQL e PHP).

- Banco de Dados do Azure para MariaDB – um sistema de gerenciamento de banco de dados mais recente, criado pelos desenvolvedores originais do MySQL. Desde então, o mecanismo de banco de dados foi reescrito e otimizado para aprimorar o desempenho. O MariaDB tem compatibilidade com o Oracle Database (outro sistema de gerenciamento de banco de dados comercial popular).

- Banco de dados do Azure para PostgreSQL – um banco de dados híbrido relacional-objeto. É possível armazenar dados em tabelas relacionais, mas um banco de dados PostgreSQL também permite que você armazene tipos de dados personalizados, com propriedades não relacionais próprias.

Assim como acontece com os sistemas de banco de dados SQL do Azure, os bancos de dados relacionais de código aberto são gerenciados por administradores de banco de dados para dar suporte a aplicativos transacionais e fornecem uma fonte de dados para engenheiros de dados, criando pipelines para soluções analíticas e analistas de dados que criam relatórios.

## Azure Cosmos DB
    O Azure Cosmos DB é um sistema de banco de dados não relacional (NoSQL) de escala global que dá suporte a várias APIs (interfaces de programação de aplicativos) e permite armazenar e gerenciar dados como documentos JSON, pares de valores-chave, famílias de colunas e gráficos.

    Em algumas organizações, instâncias do Cosmos DB podem ser provisionadas e gerenciadas por um administrador de banco de dados, embora os desenvolvedores de software tenham o costume de gerenciar o armazenamento de dados NoSQL como parte da arquitetura geral do aplicativo. Os engenheiros de dados geralmente precisam integrar fontes de dados do Cosmos DB a soluções analíticas corporativas que dão suporte à modelagem e geração de relatórios por analistas de dados.

## Armazenamento do Azure
    Contêineres de blobs – armazenamento escalonável e econômico para arquivos binários.
    Compartilhamentos de arquivos – compartilhamentos de arquivos de rede, semelhante ao que normalmente é encontrado nas redes corporativas.
    Tabelas – armazenamento de chave-valor para aplicativos que precisam ler e gravar valores de dados rapidamente.

    Os engenheiros de dados usam o Armazenamento do Azure para hospedar data lakes – armazenamentos de blobs com um namespace hierárquico que permite que os arquivos sejam organizados em pastas em um sistema de arquivos distribuído.

    armazenamento de chave-valor: É um banco de dados que armazena dados como pares CHAVE e VALOR. Exemplo:
    # Dicionário em Python é um exemplo simples
        pessoa = {
            "cpf_12345678900": {"nome": "João", "idade": 30, "cidade": "São Paulo"},
            "cpf_98765432100": {"nome": "Maria", "idade": 25, "cidade": "Rio de Janeiro"}
        }

## **Azure Data Factory**
    O Azure Data Factory é um serviço do Azure que permite definir e agendar pipelines de dados para transferir e transformar dados. Você pode integrar seus pipelines a outros serviços do Azure, possibilitando a ingestão de dados de armazenamentos de dados na nuvem, o processamento dos dados usando a computação baseada em nuvem e a manutenção dos resultados em outro armazenamento de dados.

    O Azure Data Factory é usado por engenheiros de dados para criar soluções de ETL (extração, transformação e carregamento) que preenchem os armazenamentos de dados analíticos com os dados de sistemas transacionais na organização.    

## Microsoft Fabric
    O Microsoft Fabric é uma plataforma unificada de análise de Software como Serviço (SaaS) baseada em um lakehouse aberto e governado que inclui funcionalidades para dar suporte a:

    Ingestão de dados e ETL
    Análise de data lakehouse
    Análise de data warehouse
    Ciência de Dados e aprendizado de máquina
    Análise em tempo real
    Visualização de dados
    Governança e gerenciamento de dados
    Insights baseados em IA

    Engenheiros de dados podem usar o Microsoft Fabric para criar uma solução unificada de análise de dados que combina pipelines de ingestão de dados, data warehouses, análises em tempo real, inteligência empresarial e insights baseados em IA por meio de um único serviço, tudo armazenado centralmente no Microsoft OneLake.

## **Azure Databricks**
     O Azure Databricks é uma versão integrada do Azure da plataforma popular Databricks, que combina a plataforma de processamento de dados Apache Spark com a semântica de banco de dados SQL e uma interface de gerenciamento integrada para permitir análises de dados em larga escala.

    Os engenheiros de dados podem usar as habilidades que já têm do Databricks e do Spark para criar armazenamentos de dados analíticos no Azure Databricks.

    Os analistas de dados podem usar o suporte nativo ao notebook no Azure Databricks para consultar e visualizar dados em uma interface baseada na Web fácil de usar.  

## Azure Stream Analytics  
    O Azure Stream Analytics é um mecanismo de processamento de fluxo em tempo real que captura um fluxo de dados de uma entrada, aplica uma consulta para extrair e manipular os dados dele e grava os resultados em uma saída para análise ou processamento adicional.

    Os engenheiros de dados podem incorporar o Azure Stream Analytics em arquiteturas de análise de dados que capturam fluxos dados para ingestão em um armazenamento de dados analíticos ou para visualização em tempo real.

    Streaming: Você assiste o vídeo enquanto ele chega

    FBatch: Você baixa o vídeo primeiro, depois assiste

## Azure Data Explorer
    O Azure Data Explorer é uma plataforma de análise de big data totalmente gerenciada e autônoma que oferece consultas de alto desempenho de dados de log e telemetria.

    Os analistas de dados podem usar o Azure Data Explorer para consultar e analisar dados que incluem um atributo de carimbo de data/hora, como normalmente é encontrado em arquivos de log e dados de telemetria da IoT (Internet das Coisas).

## Microsoft Purview
    O Microsoft Purview fornece uma solução corporativa para governança e descoberta de dados. Use o Microsoft Purview para criar um mapa de seus dados e acompanhar a linhagem de dados em várias fontes de dados e sistemas, permitindo encontrar dados confiáveis para análise e relatórios.

    Os engenheiros de dados podem usar o Microsoft Purview para impor a governança de dados em toda a empresa e garantir a integridade dos dados usados para dar suporte a cargas de trabalho analíticas.
