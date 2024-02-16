unit App.UI.Form.Bas.Ed.Descr_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Ed_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, App.DB.Utils,
  App.Entidade.Ed.Id.Descr;

type
  TEdDescrBasForm = class(TEdBasForm)
    LabeledEdit1: TLabeledEdit;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure LabeledEdit1Change(Sender: TObject);
  private
    { Private declarations }
  protected
    function GetEntIdDescr: IEntIdDescr;
    property EntIdDescr: IEntIdDescr read GetEntIdDescr;

    procedure AjusteControles; override;

    procedure ControlesToEnt; override;
    procedure EntToControles; override;

    function DescrOk: boolean; virtual;
    function GravouOk: boolean; virtual;
    function PodeOk: boolean; override;
  public
    { Public declarations }
  end;

var
  EdDescrBasForm: TEdDescrBasForm;

implementation

{$R *.dfm}

uses Data.DB;

procedure TEdDescrBasForm.AjusteControles;
var
  sFormat: string;
  sCaption: string;
begin
  inherited;
  LabeledEdit1.EditLabel.Caption := EntIdDescr.DescrCaption;
  case EntIdDescr.State of
    dsInactive:
      ;
    dsBrowse:
      ;
    dsEdit:
      begin
        sFormat := 'Alterando %s: %s';
        sCaption := Format(sFormat, [EntIdDescr.Nome, EntIdDescr.Descr]);
        ObjetivoLabel.Caption := sCaption;
        EntToControles;
      end;

    dsInsert:
      begin
        ObjetivoLabel.Caption := 'Novo fabricante';
      end;
  end;
end;

procedure TEdDescrBasForm.ControlesToEnt;
begin
  inherited;
  EntIdDescr.Descr := LabeledEdit1.Text;
end;

function TEdDescrBasForm.DescrOk: boolean;
var
  sFrase: string;
  sNomeCampo: string;
  iId: smallint;
  sNomeDigitado: string;
  sFormat: string;
begin
  LabeledEdit1.Text := Trim(LabeledEdit1.Text);
  sNomeDigitado := LabeledEdit1.Text;
  sNomeCampo := EntIdDescr.DescrCaption;

  Result := sNomeDigitado <> '';
  if not Result then
  begin
    sFormat := 'Campo ''%s'' é obrigatório';
    sFrase := Format(sFormat, [sNomeCampo]);
    ErroOutput.Exibir(sFrase);
    LabeledEdit1.SetFocus;
    exit;
  end;

  if EntIdDescr.State = dsEdit then
  begin
    Result := sNomeDigitado <> EntIdDescr.Descr;

    if not Result then
    begin
      sFormat := '%s igual ao já existente';
      sFrase := Format(sFormat, [sNomeCampo]);
      ErroOutput.Exibir(sFrase);
      LabeledEdit1.SetFocus;
      exit;
    end;
  end;

  iId := EntDBI.IdByDescr(sNomeDigitado);
  Result := iId < 1;
  if not Result then
  begin
    sFormat := '''%s'' já está cadastrado sob o código %d';
    sFrase := Format(sFormat,  [sNomeDigitado, iId]);
    ErroOutput.Exibir(sFrase);
    LabeledEdit1.SetFocus;
    exit;
  end;
end;

procedure TEdDescrBasForm.EntToControles;
begin
  inherited;
  LabeledEdit1.Text := EntIdDescr.Descr;
end;

function TEdDescrBasForm.GetEntIdDescr: IEntIdDescr;
begin
  Result := IEntIdDescr(EntEd);
end;

function TEdDescrBasForm.GravouOk: boolean;
var
  sFrase: string;
begin
  Result := EntDBI.GarantirRegId;
  if not Result then
  begin
    sFrase := 'Erro ao gravar '+EntIdDescr.Nome;
    ErroOutput.Exibir(sFrase);
    LabeledEdit1.SetFocus;
    exit;
  end;
end;

procedure TEdDescrBasForm.LabeledEdit1Change(Sender: TObject);
begin
  inherited;
  MensLimpar;
end;

procedure TEdDescrBasForm.LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Key := #0;
    OkAct_Diag.Execute;
    exit;
  end;
  inherited;
  EditKeyPress(Sender, Key);
end;

function TEdDescrBasForm.PodeOk: boolean;
begin
  Result := inherited PodeOk;
  if not Result then
    exit;

  Result := DescrOk;
  if not Result then
    exit;

  ControlesToEnt;

  Result := GravouOk;
  if not Result then
    exit;
end;

procedure TEdDescrBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  LabeledEdit1.SetFocus;
end;

end.
