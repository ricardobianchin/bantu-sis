unit App.Ent.DBI;

interface

uses Sis.DBI, Data.DB, Sis.DB.DBTypes, System.Classes, Sis.Entidade, App.Ent.Ed;

type
  IEntDBI = interface(IDBI)
    ['{235EBDD0-B948-4D33-929F-ED89EA4BC3EE}']

    /// <summary>
    /// Função para obter registros já existentes.
    /// </summary>
    /// <param name="pValuesArray">
    /// Array de valores a serem verificados. pode ser um id,
    /// caso o id nao seja gerado automaticamente
    /// ou algum campo unique
    ///
    /// se for so um valor, basta criar um var array de 0 a 0 elementos
    /// ou criar um array com quantos elementos forem necessarios
    ///
    /// por exemplo, para unidades de medida, tanto poderia haver unid ou sigla
    /// existente
    /// entao foi criado um array 0 a 1 com unid e sigla que se desejava inserir
    /// </param>
    /// <param name="pRetorno">
    /// Retorno da função, caso necessário.
    /// Texto descrevendo os campos que ja existem no banco
    /// separe por virgulas, sem enter, pois irá pra um label.caption  em uma area limitada
    /// </param>
    /// <returns>
    /// Array de variantes contendo as ids dos registros já existentes.
    /// </returns>
    function GetRegsJaExistentes(pValuesArray: variant;
      out pRetorno: string): variant;

    // recebe uma id ou array de loja term id
    // retorna array com os valores do reg
    // retorna true se o id existia
    function GetPackageName: string;
    property PackageName: string read GetPackageName;

    function ById(pId: variant; out pValores: variant): boolean;
    procedure ListaSelectGet(pSL: TStrings; pDBConnection: IDBConnection = nil);
    function AtivoSet(const pId: integer; Value: boolean): boolean;
    function Ler: boolean;

    // quando usuario pode indicar a id, usar estes
    function Inserir(out pNovaId: variant): boolean;
    function Alterar: boolean;
    function Gravar: boolean;
    ///

    // quando usuario NAO pode indicar a id, usar estes
    function Garantir: boolean;
    ///

    function GetEntEd: IEntEd;
    procedure SetEntEd(Value: IEntEd);
    property EntEd: IEntEd read GetEntEd write SetEntEd;

  end;

implementation

end.
