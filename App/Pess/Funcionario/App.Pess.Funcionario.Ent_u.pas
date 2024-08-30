unit App.Pess.Funcionario.Ent_u;

interface

uses App.Pess.Funcionario.Ent, App.Pess.Ent_u, App.PessEnder.List, App.Pess.Utils;

type
  TPessFuncionarioEnt = class(TPessEnt, IPessFuncionarioEnt)
  private
  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;
  public
    procedure LimparEnt; override;
  end;

implementation

uses Data.DB;

{ TPessFuncionarioEnt }

function TPessFuncionarioEnt.GetNomeEnt: string;
begin
  Result := 'Funcionário';
end;

function TPessFuncionarioEnt.GetNomeEntAbrev: string;
begin
  Result := 'Func';
end;

function TPessFuncionarioEnt.GetTitulo: string;
begin
  Result := 'Funcionários';
end;

procedure TPessFuncionarioEnt.LimparEnt;
begin
  inherited;

end;

end.
