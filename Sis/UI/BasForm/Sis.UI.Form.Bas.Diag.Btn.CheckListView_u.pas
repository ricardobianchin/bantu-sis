unit Sis.UI.Form.Bas.Diag.Btn.CheckListView_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag.Btn_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.CheckLst;

type
  TCheckListViewDiagBasForm = class(TDiagBtnBasForm)
    CheckListBox1: TCheckListBox;
    TituloLabel: TLabel;
  private
    { Private declarations }
    function GetIdsSelecionadasAsStringCSV: string;
  protected
    procedure PreencherCheckListBox; virtual;
    procedure AjusteControles; override;
    property IdsSelecionadasAsStringCSV: string read GetIdsSelecionadasAsStringCSV;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pCaption: TCaption;
      pTitulo: TCaption); reintroduce; virtual;
  end;

var
  CheckListViewDiagBasForm: TCheckListViewDiagBasForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils;

{ TCheckListViewDiagBasForm }

procedure TCheckListViewDiagBasForm.AjusteControles;
begin
  inherited;
  PreencherCheckListBox;
  CheckListBox1.SetFocus;
end;

constructor TCheckListViewDiagBasForm.Create(AOwner: TComponent; pCaption,
  pTitulo: TCaption);
begin
  inherited Create(AOwner);
  Caption := pCaption;
  TituloLabel.Caption := pTitulo;
  CheckListBox1.Align := alClient;
  Height := GetToolFormHeight;
end;

function TCheckListViewDiagBasForm.GetIdsSelecionadasAsStringCSV: string;
var
  PPointerAtual: Pointer;
  iIdAtual: integer;
  bTem: boolean;
  i: integer;
begin
  Result := '';
  for I := 0 to CheckListBox1.Items.Count - 1 do
  begin
    bTem := CheckListBox1.Checked[i];
    if not bTem then
      Continue;

    PPointerAtual := CheckListBox1.Items.Objects[i];
    iIdAtual := Integer(PPointerAtual);
    if Result <> '' then
      Result := Result + ';';
    Result := Result + iIdAtual.ToString;
  end;
end;

procedure TCheckListViewDiagBasForm.PreencherCheckListBox;
begin
  CheckListBox1.Clear;
end;

end.
