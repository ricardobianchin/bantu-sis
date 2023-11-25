unit App.UI.Form.Bas.Princ_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas_u, Vcl.ExtCtrls,
  App.AppInfo, App.AppObj;

type
  TPrincBasForm = class(TBasForm)
    procedure FormCreate(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FAppInfo: IAppInfo;
    FAppObj: IAppObj;
  protected
    property AppInfo: IAppInfo read FAppInfo;
    property AppObj: IAppObj read FAppObj;
  public
    { Public declarations }
  end;

var
  PrincBasForm: TPrincBasForm;

implementation

uses App.Factory, App.UI.Form.Status_u;

{$R *.dfm}

procedure TPrincBasForm.FormCreate(Sender: TObject);
begin
  StatusForm := TStatusForm.Create(nil);
  StatusForm.Show;
  inherited;
  DisparaShowTimer := True;
  FAppInfo := App.Factory.AppInfoCreate(Application.ExeName);
  FAppObj := App.Factory.AppObjCreate(FAppInfo);

end;

procedure TPrincBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  FreeAndNil(StatusForm);
end;

end.
