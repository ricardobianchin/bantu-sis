unit App.UI.Form.Bas.Ed_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas.Diag.Btn_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Data.DB, App.Entidade.Ed, App.Ent.DBI;

type
  TEdBasForm = class(TDiagBtnBasForm)
    ObjetivoLabel: TLabel;
  private
    { Private declarations }
    FEntEd: IEntEd;
    FEntDBI: IEntDBI;
    procedure AjusteCaption;
  protected
    property EntEd: IEntEd read FEntEd;
    property EntDBI: IEntDBI read FEntDBI;

    procedure AjusteControles; override;

    procedure ControlesToEnt; virtual; abstract;
    procedure EntToControles; virtual; abstract;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pEntEd: IEntEd; pEntDBI: IEntDBI); reintroduce;
  end;

var
  EdBasForm: TEdBasForm;

implementation

{$R *.dfm}

uses App.DB.Utils;

{ TEdBasForm }

procedure TEdBasForm.AjusteControles;
begin
  AjusteCaption;
end;

procedure TEdBasForm.AjusteCaption;
var
  sCaption: string;
  sTitulo, sState: string;
begin
  sTitulo := EntEd.Titulo;
  sState := DataSetStateToTitulo(EntEd.State);

  sCaption := Format('%s - %s', [sTitulo, sState]);

  Caption := sCaption;
end;

constructor TEdBasForm.Create(AOwner: TComponent; pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  inherited Create(AOwner);
  FEntEd := pEntEd;
  FEntDBI := pEntDBI;
end;

end.
