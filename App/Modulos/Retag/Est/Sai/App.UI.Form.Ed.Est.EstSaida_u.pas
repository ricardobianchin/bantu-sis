unit App.UI.Form.Ed.Est.EstSaida_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Ed.Est_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, App.Ent.Ed, App.Ent.DBI, App.AppObj,
  App.Retag.Est.EstSaida.Ent, App.Retag.Est.EstSaida.DBI;

type
  TEstSaidaEdForm = class(TEstEdBasForm)
  private
    { Private declarations }
    FEstSaidaEnt: IEstSaidaEnt;
    FEstSaidaDBI: IEstSaidaDBI;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
      pEntDBI: IEntDBI); override;
  end;

var
  EstSaidaEdForm: TEstSaidaEdForm;

implementation

{$R *.dfm}

uses App.Retag.Est.Factory;

{ TEstSaidaEdForm }

constructor TEstSaidaEdForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  inherited;
  FEstSaidaEnt := EntEdCastToEstSaidaEnt(pEntEd);
  FEstSaidaDBI := EntDBICastToEstSaidaDBI(pEntDBI);

end;

end.
