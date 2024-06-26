unit App.Pess.Ender.DBGrid.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.DBGrid_u, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, App.Pess.Ent,
  App.Pess.DBI;

type
  TEnderDBGridFrame = class(TDBGridFrame)
  private
    { Private declarations }
    FPessEnt: IPessEnt;
    FPessDBI: IPessDBI;
    FEnderPessFDMemTable: TFDMemTable;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pPessEnt: IPessEnt;
      pPessDBI: IPessDBI; pEnderPessFDMemTable: TFDMemTable); reintroduce;
    procedure AjusteControles;
    procedure ControlesToEnt;
    procedure EntToControles;
  end;

//var
//  EnderDBGridFrame: TEnderDBGridFrame;

implementation

{$R *.dfm}

{ TEnderDBGridFrame }

procedure TEnderDBGridFrame.AjusteControles;
begin

end;

procedure TEnderDBGridFrame.ControlesToEnt;
begin

end;

constructor TEnderDBGridFrame.Create(AOwner: TComponent; pPessEnt: IPessEnt;
  pPessDBI: IPessDBI; pEnderPessFDMemTable: TFDMemTable);
begin
  inherited Create(AOwner);
  FPessEnt := pPessEnt;
  FPessDBI := pPessDBI;
  FEnderPessFDMemTable := pEnderPessFDMemTable;
end;

procedure TEnderDBGridFrame.EntToControles;
begin

end;

end.
