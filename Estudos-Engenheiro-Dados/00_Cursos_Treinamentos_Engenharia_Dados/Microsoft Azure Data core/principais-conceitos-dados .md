
## Links:
    https://learn.microsoft.com/pt-br/training/paths/azure-data-fundamentals-explore-core-data-concepts/
## Identificar formatos de dados 
    Os dados são uma coleção de fatos, como números, descrições e observações usados para registrar informações. As estruturas de dados nas quais esses dados são organizados geralmente representam entidades que são importantes para uma organização (como clientes, produtos, ordens de venda etc.). Normalmente, cada entidade tem um ou mais atributos ou características (por exemplo, um cliente pode ter um nome, um endereço, um número de telefone e assim por diante).

## Podemos classificar os dados como estruturados, semiestruturados ou não estruturados.
    Dados estruturados
        Dados estruturados obedecem a um esquema fixo, portanto, todos os dados têm os mesmos campos ou propriedades. Normalmente, o esquema para entidades de dados estruturados é tabular. Em outras palavras, os dados são representados em uma ou mais tabelas que consistem em linhas para representar cada instância de uma entidade de dados e colunas para representar os atributos da entidade. Por exemplo, a imagem a seguir mostra representações de dados tabulares para as entidades Customer e Product.

## Dados semiestruturados   
    Dados semiestruturados são informações que têm alguma estrutura, mas que permitem alguma variação entre instâncias da entidade. Por exemplo, embora a maioria dos clientes possa ter um endereço de email, alguns podem ter vários endereços de email e outros podem não ter nenhum.

    Um formato comum para dados semiestruturados é o JSON (JavaScript Object Notation). O exemplo a seguir mostra um par de documentos JSON que representam informações do cliente. Cada documento do cliente inclui informações de endereço e de contato, mas os campos específicos variam entre os clientes. Exemplo :

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

## A capacidade de armazenar dados em arquivos é um elemento básico de qualquer sistema computacional. 
    Os arquivos podem ser armazenados em sistemas de arquivos locais no disco rígido do seu PC e em mídia removível, como unidades USB. Mas, na maioria das organizações, arquivos de dados importantes são armazenados de maneira centralizada em algum tipo de sistema de armazenamento de arquivos compartilhado. Cada vez mais, esse local de armazenamento central está sendo hospedado na nuvem, possibilitando um armazenamento econômico, seguro e confiável para grandes volumes de dados.

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

    {
        "customers":
        [
          {
            "firstName": "Joe",
            "lastName": "Jones",
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
        },
            {
            "firstName": "Samir",
            "lastName": "Nadoy",
            "contact":
            [
                {
                "type": "email",
                "address": "samir@northwind.com"
                }
            ]
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

    Alguns formatos de arquivo otimizados comuns que você pode ver incluem Avro, ORC e Parquet:

    - Avro é um formato baseado em linha. Ele foi criado pelo Apache. Cada registro contém um cabeçalho que descreve a estrutura dos dados no registro. Esse cabeçalho é armazenado como JSON. Os dados são armazenados como informações binárias. Um aplicativo usa as informações no cabeçalho para analisar os dados binários e extrair os campos contidos neles. O Avro é um formato bom para compactar dados e minimizar os requisitos de armazenamento e largura de banda de rede.

    - ORC (formato Columnar de Linha Otimizada) organiza dados em colunas em vez de linhas. Ele foi desenvolvido pela HortonWorks para otimizar as operações de leitura e gravação no Apache Hive (o Hive é um sistema de data warehouse que dá suporte a resumos rápidos de dados e consultas em grandes conjuntos de dados). Um arquivo ORC contém faixas de dados. Cada faixa contém os dados de uma coluna ou conjunto de colunas. Uma faixa contém um índice nas linhas na faixa, os dados de cada linha e um rodapé que contém informações estatísticas (contagem, soma, máximo, mínimo e assim por diante) para cada coluna.

    - Parquet é outro formato de dados columnar. Ele foi criado pelo Cloudera e X. Um arquivo Parquet contém grupos de linhas. Os dados de cada coluna são armazenados juntos no mesmo grupo de linhas. Cada grupo de linhas contém uma ou mais partes de dados. Um arquivo Parquet inclui metadados que descrevem o conjunto de linhas encontrado em cada parte. Um aplicativo pode usar esses metadados para localizar rapidamente a parte correta de um determinado conjunto de linhas e recuperar os dados nas colunas especificadas para essas linhas. O Parquet é especialista em armazenar e processar tipos de dados aninhados com eficiência. Ele dá suporte a esquemas de codificação e compactação muito eficientes.    

## Bancos de dados relacionais
    Os bancos de dados relacionais são comumente usados para armazenar e consultar dados estruturados. Os dados são armazenados em tabelas que representam entidades, como clientes, produtos ou pedidos de venda. Cada instância de uma entidade recebe uma chave primária que a identifica de maneira exclusiva. 
    
    Essas chaves são usadas para fazer referência à instância da entidade em outras tabelas. Por exemplo, a chave primária de um cliente pode ser referenciada em um registro de pedido de venda para indicar qual cliente fez o pedido. Esse uso de chaves para referenciar entidades de dados permite que um banco de dados relacional seja normalizado, o que, em parte, significa a eliminação de valores de dados duplicados para que, por exemplo, os detalhes de um cliente individual sejam armazenados apenas uma vez e não para cada pedido de vendas que o cliente faz. As tabelas são gerenciadas e consultadas usando a linguagem SQL, que se baseia em um padrão ANSI e que, portanto, é semelhante entre vários sistemas de banco de dados.

## Bancos de dados não relacionais
    Os bancos de dados não relacionais são sistemas de gerenciamento de dados que não aplicam um esquema relacional aos dados. Os bancos de dados não relacionais geralmente são chamados de banco de dados NoSQL, embora alguns ofereçam suporte a uma variante da linguagem SQL.

## Há quatro tipos comuns de banco de dados não relacionais normalmente em uso:
    - Bancos de dados de chave-valor nos quais cada registro consiste em uma chave exclusiva e um valor associado, que pode estar em qualquer formato.

    - Bancos de dados de documentos, que são uma forma específica de banco de dados de chave-valor na qual o valor é um documento JSON (em que o sistema é otimizado para análise e consulta)

    - Bancos de dados de família de colunas que podem armazenar dados tabulares que abrangem linhas e colunas; você também pode dividir as colunas em grupos conhecidos como famílias de colunas. Cada família de colunas contém um conjunto de colunas que estão logicamente relacionadas.

    - Bancos de dados de grafo, que armazenam entidades como nós com links para definir relações entre eles.

## Explorar o processamento de dados transacionais
    Um sistema de processamento de dados transacionais é o que a maioria das pessoas considera a principal função da computação empresarial. Um sistema transacional registra transações que encapsulam eventos específicos que a organização deseja controlar. Uma transação pode ser financeira, como a movimentação de dinheiro entre contas em um sistema bancário, ou pode fazer parte de um sistema de varejo, controlando pagamentos de bens e serviços de clientes. Pense na transação como uma unidade de trabalho pequena e discreta.

    Os sistemas transacionais geralmente são de alto volume, às vezes manipulando muitos milhões de transações em um dia. Os dados que estão sendo processados têm que estar acessíveis com rapidez. O trabalho executado por sistemas transacionais é geralmente conhecido como OLTP (Processamento de Transações Online).

    As soluções OLTP dependem de um sistema de banco de dados no qual o armazenamento de dados é otimizado para operações de leitura e gravação para dar suporte a cargas de trabalho transacionais nas quais os registros de dados são criados, recuperados, atualizados e excluídos (essas operações são geralmente chamadas de CRUD). Essas operações são aplicadas de maneira transacional para garantir a integridade dos dados armazenados no banco de dados. Para fazer isso, os sistemas OLTP impõem transações compatíveis com a semântica conhecida como ACID:

    Atomicidade – cada transação é tratada como uma única unidade, que é totalmente bem-sucedida ou que falha completamente. Por exemplo, uma transação que envolve o débito de fundos de uma conta e o crédito do mesmo valor em outra conta deve concluir ambas as ações. Se uma das ações não puder ser concluída, a outra ação deverá falhar.

    Consistência – as transações só podem conduzir os dados do banco de dados de um estado válido para outro estado válido. Para continuar com o exemplo de débito e crédito acima, o estado concluído da transação deve refletir na transferência de fundos de uma conta para outra.

    Isolamento – as transações simultâneas não podem interferir entre si e devem resultar em um estado consistente do banco de dados. Por exemplo, enquanto a transação para transferir fundos de uma conta para outra está em processo, outra transação que verifica o saldo dessas contas deve retornar resultados consistentes – a transação de verificação de saldo não pode recuperar um valor para uma conta que reflita o saldo antes da transferência e um valor para a outra conta que reflita o saldo após a transferência.

    Durabilidade – quando uma transação tiver sido confirmada, ela permanecerá confirmada. Depois que a transação de transferência entre contas for concluída, os saldos de conta revisados serão persistidos para que, mesmo que o sistema do banco de dados seja desligado, a transação confirmada seja refletida quando ele for ligado novamente.

    Os sistemas OLTP normalmente são usados para dar suporte a aplicativos dinâmicos que processam dados de negócios, geralmente chamados de aplicativos de LOB (linha de negócios).

## Explorar o processamento de dados analíticos
    O processamento de dados analíticos normalmente usa sistemas somente leitura (ou read-mostly) que armazenam grandes volumes de dados históricos ou métricas de negócios. A análise pode ser baseada em um instantâneo dos dados em um determinado momento ou em uma série de instantâneos.

    Os detalhes específicos de um sistema de processamento analítico podem variar entre as soluções, mas uma arquitetura comum de análise de escala empresarial tem esta aparência:

    Os dados operacionais são extraídos, transformados e carregados (ETL) em um data lake para análise.

    Os dados são carregados em um esquema de tabelas – normalmente em um data lakehouse baseado em Spark com abstrações tabulares em arquivos no data lake ou em um data warehouse com um mecanismo SQL totalmente relacional.

    Os dados no data warehouse podem ser agregados e carregados em um modelo OLAP (processamento analítico online) ou cubo. Valores numéricos agregados (medidas) de tabelas de fatos são calculados para interseções de dimensões da tabelas de dimensões. Por exemplo, a receita de vendas pode ser totalizada por data, cliente e produto.

    Os dados no data lake, no data warehouse e no modelo analítico podem ser consultados para produzir relatórios, visualizações e painéis.

## Data lakes são comuns em cenários de processamento analítico de dados em grande escala, em que um grande volume de dados baseados em arquivo precisa ser coletado e analisado.

## Data warehouses
    Data warehouses são uma forma estabelecida de armazenar dados em um esquema relacional otimizado para operações de leitura – principalmente consultas para dar suporte a relatórios e à visualização de dados. Os Data Lakehouses são uma inovação mais recente que combina o armazenamento flexível e escalonável de um data lake com a semântica de consulta relacional de um data warehouse. O esquema de tabela pode exigir alguma desnormalização de dados em uma fonte de dados OLTP (apresentando algumas duplicações para fazer com que as consultas sejam executadas mais rapidamente).

## Modelo OLAP
    Um modelo OLAP é um tipo agregado de armazenamento de dados que é otimizado para cargas de trabalho analíticas. As agregações de dados são feitas entre dimensões em diferentes níveis, permitindo que você faça drill up/down para exibir agregações em vários níveis hierárquicos; por exemplo, para localizar o total de vendas por região, por cidade ou por um endereço individual. Como os dados do OLAP são previamente agregados, as consultas para retornar os resumos que ele contém podem ser executadas rapidamente.

    
## Tipos diferentes de usuários podem executar trabalhos de análise de dados em diferentes estágios da arquitetura geral. Por exemplo:
    Os cientistas de dados podem trabalhar diretamente com arquivos de dados em um data lake para explorar e modelar os dados.
    Os Analistas de Dados podem consultar tabelas diretamente no data warehouse para produzir relatórios e visualizações complexos.
    Os usuários empresariais podem consumir dados previamente agregados em um modelo analítico na forma de relatórios ou painéis.

## Resumo
    Os dados estão na essência da maioria dos aplicativos e soluções de software. Eles podem ser representados em vários formatos, armazenados em arquivos e bancos de dados e usados para registrar transações ou para oferecer suporte à análise e à criação de relatórios.

    Neste módulo, você aprendeu a:

    Identificar formatos de dados comuns
    Descrever as opções para armazenar dados em arquivos
    Descrever as opções para armazenar dados em bancos de dados
    Descrever as características das soluções de processamento de dados transacionais
    Descrever as características de soluções de processamento de dados analíticos