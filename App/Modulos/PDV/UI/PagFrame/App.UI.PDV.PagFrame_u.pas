unit App.UI.PDV.PagFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.PDV.VendaBasFrame_u, Vcl.ExtCtrls,
  Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Stan.StorageBin, Vcl.ToolWin, Vcl.ComCtrls;

type
  TPagPDVFrame = class(TVendaBasPDVFrame)
    TotPanel: TPanel;
    PagoLabel: TLabel;
    TotLabel: TLabel;
    FaltaLabel: TLabel;
    TrocoLabel: TLabel;
    DBGrid1: TDBGrid;
    VendaPagFDMemTable: TFDMemTable;
    VendaPagFDMemTableOrdem: TSmallintField;
    VendaPagFDMemTableDescr: TStringField;
    VendaPagFDMemTableValor: TCurrencyField;
    VendaPagDataSource: TDataSource;
    VendaPagFDMemTableCancelado: TBooleanField;
    BasePanel: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    procedure ToolButton1Click(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure PegPerg;
  public
    { Public declarations }
    procedure PagSomenteDinheiro;
    procedure DimensioneControles; override;


  end;

var
  PagPDVFrame: TPagPDVFrame;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, App.UI.PDV.PagPergForm_u;

{ TPagPDVFrame }

procedure TPagPDVFrame.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case key of
    VK_INSERT: PegPerg;
  end;
end;

procedure TPagPDVFrame.DimensioneControles;
begin
  inherited;
  MeioPanel.Width := 800;
  MeioPanel.Height := 550;
  MeioPanel.BevelOuter := bvNone;
  TotPanel.BevelOuter := bvNone;

  ControlAlignToRect(MeioPanel, Self.ClientRect);

  VendaPagFDMemTable.EmptyDataSet;
end;

procedure TPagPDVFrame.PagSomenteDinheiro;
begin
  PDVDBI.PagSomenteDinheiro;
  PDVControlador.VaParaFinaliza;
end;

procedure TPagPDVFrame.PegPerg;
var
  bResultado: Boolean;
begin
  PagPergForm := TPagPergForm.Create(Nil, PDVVenda, PDVDBI);
  try
    bResultado := PagPergForm.Perg;
  finally
    PagPergForm.Free;
  end;

end;

procedure TPagPDVFrame.ToolButton1Click(Sender: TObject);
begin
  inherited;
  PegPerg;
end;

end.
