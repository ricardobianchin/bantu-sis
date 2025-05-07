unit App.UI.Form.Ed.Est_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, App.Ent.Ed, App.Ent.DBI, App.AppObj;

type
  TEstEdBasForm = class(TEdBasForm)
    CodLabeledEdit: TLabeledEdit;
  private
    { Private declarations }
  protected
    procedure AjusteControles; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
      pEntDBI: IEntDBI); override;
  end;

var
  EstEdBasForm: TEstEdBasForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils;

{ TEstEdBasForm }

procedure TEstEdBasForm.AjusteControles;
begin
  inherited;
  ReadOnlySet(CodLabeledEdit);
end;

constructor TEstEdBasForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  inherited;
  //
end;

end.
