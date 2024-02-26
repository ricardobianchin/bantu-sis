unit App.UI.Form.Ed.Prod_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Ed_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, NumEditBtu,
  App.Retag.Est.Prod.Ent, Data.DB;

type
  TProdEdForm = class(TEdBasForm)
    DescrLabeledEdit: TLabeledEdit;
    DescrRedLabeledEdit: TLabeledEdit;
    FabrComboBox: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Label3: TLabel;
    ComboBox2: TComboBox;
    Label4: TLabel;
    ComboBox3: TComboBox;
    LabeledEdit3: TLabeledEdit;
    AtivoCheckBox: TCheckBox;
    Label5: TLabel;
    ComboBox4: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FIdNumEdit: TNumEditBtu;
    FCustoAtualNumEdit: TNumEditBtu;
    FPrecoAtualNumEdit: TNumEditBtu;

    function GetProdEnt: IProdEnt;
    property ProdEnt: IProdEnt read GetProdEnt;
    function GetAlterado: boolean;

  protected
    function GetObjetivoStr: string; override;
    procedure AjusteControles; override;
    procedure ControlesToEnt; override;
    procedure EntToControles; override;

    function ControlesOk: boolean; override;
    function DadosOk: boolean; override;
    function GravouOk: boolean; override;
  public
    { Public declarations }
  end;

var
  ProdEdForm: TProdEdForm;

implementation

uses App.Retag.Est.Prod.Ent_u, Sis.UI.Controls.TLabeledEdit;

{$R *.dfm}

procedure TProdEdForm.AjusteControles;
var
  sFormat: string;
  sCaption: string;
  sNom, sDes: string;
begin
  inherited;
  case EntEd.State of
    dsInactive:
      ;
    dsBrowse:
      ;
    dsEdit:
      begin
        sNom := ProdEnt.NomeEnt;
        sDes := ProdEnt.Descr;

        sFormat := 'Alterando %s: %s';
        sCaption := Format(sFormat, [sNom, sDes]);

        ObjetivoLabel.Caption := sCaption;
      end;

    dsInsert:
      ;
  end;
end;

function TProdEdForm.ControlesOk: boolean;
begin

end;

procedure TProdEdForm.ControlesToEnt;
begin
  inherited;

end;

function TProdEdForm.DadosOk: boolean;
begin

end;

procedure TProdEdForm.EntToControles;
begin
  inherited;
  FIdNumEdit.Valor := ProdEnt.Id;
  DescrLabeledEdit.Text := ProdEnt.Descr;
  DescrRedLabeledEdit.Text := ProdEnt.DescrRed;
end;

procedure TProdEdForm.FormCreate(Sender: TObject);
begin
  inherited;
  FIdNumEdit := TNumEditBtu.Create(Self);
  FIdNumEdit.Parent := Self;
  FIdNumEdit.Alignment := taCenter;
  FIdNumEdit.NCasas:=0;
  FIdNumEdit.NCasasEsq:=7;

  FIdNumEdit.MascEsq := '0000000';

  FIdNumEdit.Left := ObjetivoLabel.Left;
  FIdNumEdit.Top := ObjetivoLabel.Top + Round(ObjetivoLabel.Height * 2.5);
  FIdNumEdit.Width := 60;
  FIdNumEdit.Caption := 'Código';


  FCustoAtualNumEdit := TNumEditBtu.Create(Self);
  FCustoAtualNumEdit.Parent := Self;
  FCustoAtualNumEdit.Alignment := taRightJustify;
  FCustoAtualNumEdit.NCasas:=2;
  FCustoAtualNumEdit.NCasasEsq:=7;

  FCustoAtualNumEdit.MascEsq := '';

  FCustoAtualNumEdit.Left := ObjetivoLabel.Left;
  FCustoAtualNumEdit.Top := 144;
  FCustoAtualNumEdit.Width := 70;
  FCustoAtualNumEdit.Caption := 'Custo atual';


  FPrecoAtualNumEdit := TNumEditBtu.Create(Self);
  FPrecoAtualNumEdit.Parent := Self;
  FPrecoAtualNumEdit.Alignment := taRightJustify;
  FPrecoAtualNumEdit.NCasas:=2;
  FPrecoAtualNumEdit.NCasasEsq:=7;

  FPrecoAtualNumEdit.MascEsq := '';

  FPrecoAtualNumEdit.Left := 88;
  FPrecoAtualNumEdit.Top := 144;
  FPrecoAtualNumEdit.Width := 70;
  FPrecoAtualNumEdit.Caption := 'Preço Atual';





//  FIdNumEdit.OnKeyPress := PercNumEditKeyPress;
//  FIdNumEdit.OnChange := PercNumEditChange;

end;

function TProdEdForm.GetAlterado: boolean;
begin
  Result := true;
end;

function TProdEdForm.GetObjetivoStr: string;
var
  sFormat, sTit, sNom, sDes: string;
begin
  sTit := EntEd.StateAsTitulo;
  sNom := ProdEnt.NomeEnt;
  sDes := ProdEnt.Descr;

  sFormat := '%s %s: %s';
  Result := Format(sFormat, [sTit, sNom, sDes]);
end;

function TProdEdForm.GetProdEnt: IProdEnt;
begin
  Result := TProdEnt(EntEd);
end;

function TProdEdForm.GravouOk: boolean;
begin

end;

procedure TProdEdForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  DescrLabeledEdit.SetFocus;
end;

end.
