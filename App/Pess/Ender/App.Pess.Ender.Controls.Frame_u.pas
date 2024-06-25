unit App.Pess.Ender.Controls.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas_u, App.Pess.Ent, App.Pess.DBI, Data.DB, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.StdCtrls, Sis.UI.Controls.Utils,
  Sis.UI.Controls.ComboBox.Frame_u;

type
  TEnderControlsFrame = class(TBasFrame)
    LogradouroLabel: TLabel;
    LogradouroEdit: TEdit;
    TopoPanel: TPanel;
    EnderStatusLabel: TLabel;
    NumeroLabel: TLabel;
    NumeroEdit: TEdit;
    ComplementoLabel: TLabel;
    Edit1: TEdit;
    BairroLabel: TLabel;
    Edit2: TEdit;
    Label1: TLabel;
    Edit3: TEdit;
    MunicipioSubPanel: TPanel;
  private
    { Private declarations }
    FPessEnt: IPessEnt;
    FPessDBI: IPessDBI;
    FEnderPessFDMemTable: TFDMemTable;
    CEPComboBoxBasFrame: TComboBoxBasFrame;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pPessEnt: IPessEnt;
      pPessDBI: IPessDBI; pEnderPessFDMemTable: TFDMemTable); reintroduce;
    procedure AjusteControles;
  end;

var
  EnderControlsFrame: TEnderControlsFrame;

implementation

{$R *.dfm}
{ TEnderControlsFrame }

constructor TEnderControlsFrame.Create(AOwner: TComponent; pPessEnt: IPessEnt;
  pPessDBI: IPessDBI; pEnderPessFDMemTable: TFDMemTable);
begin
  inherited Create(AOwner);
  FPessEnt := pPessEnt;
  FPessDBI := pPessDBI;
  FEnderPessFDMemTable := pEnderPessFDMemTable;
  CEPComboBoxBasFrame := TComboBoxBasFrame.Create(Self);
end;

procedure TEnderControlsFrame.AjusteControles;
begin
  PegueFormatoDe(CEPComboBoxBasFrame, MunicipioSubPanel);
end;

end.
