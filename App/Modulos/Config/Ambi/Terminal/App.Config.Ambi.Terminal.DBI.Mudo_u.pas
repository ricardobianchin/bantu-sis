unit App.Config.Ambi.Terminal.DBI.Mudo_u;

interface

uses Sis.DBI_u, App.Config.Ambi.Terminal.DBI, FireDAC.Comp.Client;

type
  TConfigAmbiTerminalDBIMudo = class(TDBI, IConfigAmbiTerminalDBI)
  private
  public
    procedure PreenchaDataSet(pDMemTable: TFDMemTable);
    procedure Inserir(pDMemTable: TFDMemTable);
    procedure Alterar(pDMemTable: TFDMemTable);
    constructor Create;
  end;

implementation

{ TConfigAmbiTerminalDBIMudo }

procedure TConfigAmbiTerminalDBIMudo.Alterar(pDMemTable: TFDMemTable);
begin

end;

constructor TConfigAmbiTerminalDBIMudo.Create;
begin
  inherited Create(nil);
end;

procedure TConfigAmbiTerminalDBIMudo.Inserir(pDMemTable: TFDMemTable);
begin

end;

procedure TConfigAmbiTerminalDBIMudo.PreenchaDataSet(pDMemTable: TFDMemTable);
begin

end;

end.
