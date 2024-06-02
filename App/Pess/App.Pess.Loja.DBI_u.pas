unit App.Pess.Loja.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u,
  App.Pess.Loja.Ent, App.Ent.Ed, App.Pess.Factory_u;

type
  TPessLojaDBI = class(TEntDBI)
  private
    function GetPessLojaEnt: IPessLojaEnt;
    property Ent: IPessLojaEnt read GetPessLojaEnt;
  protected
    function GetSqlPreencherDataSet(pValues: variant): string; override;
    procedure SetNovaId(pId: variant); override;
  public
    function Inserir(out pNovaId: variant): boolean; override;
    function Alterar: boolean; override;
    function Ler: boolean; override;
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u, App.Est.Types_u, Sis.Lists.Types,
  Sis.Win.Utils_u, Vcl.Dialogs, Sis.Types.Bool_u, Sis.Types.Floats;

{ TPessLojaDBI }

function TPessLojaDBI.Alterar: boolean;
begin

end;

function TPessLojaDBI.GetPessLojaEnt: IPessLojaEnt;
begin

end;

function TPessLojaDBI.GetSqlPreencherDataSet(pValues: variant): string;
begin

end;

function TPessLojaDBI.Inserir(out pNovaId: variant): boolean;
begin

end;

function TPessLojaDBI.Ler: boolean;
begin

end;

procedure TPessLojaDBI.SetNovaId(pId: variant);
begin
  inherited;

end;

end.
