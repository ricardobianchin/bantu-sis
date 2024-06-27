unit App.UI.Form.Bas.Ed.Pess.Loja_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed.Pess_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, App.Pess.Ent.Factory_u, App.Pess.Loja.DBI,
  App.Pess.Loja.Ent, App.AppInfo, App.Ent.Ed, App.Ent.DBI, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ComCtrls;

type
  TPessLojaEdForm = class(TPessEdBasForm)
    AtivoCheckBox: TCheckBox;
    procedure AtivoCheckBoxKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FPessLojaEnt: IPessLojaEnt;
    FPessLojaDBI: IPessLojaDBI;
  protected
    procedure AjusteTabOrder; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppInfo: IAppInfo; pEntEd: IEntEd;
      pEntDBI: IEntDBI); override;
  end;

var
  PessLojaEdForm: TPessLojaEdForm;

implementation

{$R *.dfm}

procedure TPessLojaEdForm.AjusteTabOrder;
var
  iTabOrder: integer;
begin
  inherited;
  iTabOrder := DtNascDateTimePicker.TabOrder + 1;
  AtivoCheckBox.TabOrder := iTabOrder;
end;

procedure TPessLojaEdForm.AtivoCheckBoxKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  CheckBoxKeyPress(Sender, Key);
end;

constructor TPessLojaEdForm.Create(AOwner: TComponent; pAppInfo: IAppInfo;
  pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  FPessLojaEnt := EntEdCastToPessLojaEnt(pEntEd);
  FPessLojaDBI := EntDBICastToPessLojaDBI(pEntDBI);
  inherited;
end;

end.
