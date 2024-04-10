unit App.FIn.PagFormaTipo;

interface

uses Sis.Lists.HashItem;

type
  IPagFormaTipo = interface(IHashItem)
    ['{CD087B02-DFAD-4E7D-BE9D-23965B52E71D}']

    function GetDescrRed: string;
    procedure SetDescrRed(const Value: string);
    property DescrRed: string read GetDescrRed write SetDescrRed;

    function GetAtivo: Boolean;
    procedure SetAtivo(Value: Boolean);
    property Ativo: Boolean read GetAtivo write SetAtivo;
  end;
{
PAGAMENTO_FORMA_TIPO_ID         (ID_CHAR_DOM) CHAR(1) CHARACTER SET WIN1252 Not Null
DESCR                           (NOME_INTERM_DOM) VARCHAR(40) CHARACTER SET WIN1252 Not Null
DESCR_RED                       CHAR(6) CHARACTER SET WIN1252 Not Null
ATIVO                           BOOLEAN Not Null
}
implementation

end.
