unit App.UI.Frame.Control.EditSelect_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.Control_u,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.Buttons, Sis.Ui.Img.Utils,
  NumEditBtu, App.Ent.Ed, App.Ent.DBI, Sis.UI.IO.Output;

type
  TSelectEditFrame = class(TControlBasFrame)
    FundoPanel: TPanel;
    BuscaLabeledEdit: TLabeledEdit;
    ValorLabeledEdit: TLabeledEdit;
    BuscaBitBtn: TBitBtn;
    TitLabel: TLabel;
    procedure ValorLabeledEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FIdNumEdit: TNumEditBtu;
    FEntEd: IEntEd;
    FEntDBI: IEntDBI;
    FErroOutput: IOutput;

    procedure IdCrie;
    procedure IdNumEditKeyPress(Sender: TObject; var Key: Char);
  protected
    property ErroOutput: IOutput read FErroOutput;
  protected
  public
    { Public declarations }
    property IdNumEdit: TNumEditBtu read FIdNumEdit;
    constructor Create(AOwner: TComponent; pEntEd: IEntEd; pEntDBI: IEntDBI; pErroOutput: IOutput); reintroduce;
  end;

//var
//  SelectEditFrame: TSelectEditFrame;

implementation

{$R *.dfm}

{ TControlBasFrame1 }

constructor TSelectEditFrame.Create(AOwner: TComponent; pEntEd: IEntEd; pEntDBI: IEntDBI; pErroOutput: IOutput);
var
  sNomeArq: string;
begin
  inherited Create(AOwner);
  IdCrie;
  FEntEd := pEntEd;
  FEntDBI := pEntDBI;
  FErroOutput := pErroOutput;
  TitLabel.Caption := pEntEd.NomeEnt;
  ValorLabeledEdit.Text := pEntEd.AsStringExib;
  //ValorLabeledEdit.EditLabel.Caption := pEntEd.Titulo;
  sNomeArq := ImgsList.ImgIndexToFileName(ImgIndexesSis.Lupa16);
//  BuscaBitBtn.Glyph.LoadFromFile(sNomeArq);
end;

procedure TSelectEditFrame.IdNumEditKeyPress(Sender: TObject; var Key: Char);
begin
  //FEntDBI.
//  TitLabel.Caption := 'press';
end;

procedure TSelectEditFrame.ValorLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if key=#32 then
    TitLabel.Caption := 'dd';
end;

procedure TSelectEditFrame.IdCrie;
begin
  FIdNumEdit := TNumEditBtu.Create(Self);
  FIdNumEdit.Parent := Self;
  FIdNumEdit.Alignment := taCenter;
  FIdNumEdit.Caption := 'Código';

//  FIdNumEdit.Left := BuscaBitBtn.Left+BuscaBitBtn.Width+3;
  FIdNumEdit.Left := 50;
  FIdNumEdit.Top := BuscaLabeledEdit.Top;
  FIdNumEdit.Width := 62;
  FIdNumEdit.Height := 23;
  FIdNumEdit.OnKeyPress := IdNumEditKeyPress;
  FIdNumEdit.NCasasEsq := 7;
  FIdNumEdit.LabelPosition := lpLeft;
  FIdNumEdit.LabelSpacing := 4;
end;

end.
