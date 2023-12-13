unit Sis.UI.Form.Bas.Act_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas_u, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList;

type
  TActBasForm = class(TBasForm)
    ActionList1_ActBasForm: TActionList;
    FecharAction_ActBasForm: TAction;
    procedure FecharAction_ActBasFormExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }

  protected
    procedure FecheForm; virtual;

  public
    { Public declarations }
  end;

var
  ActBasForm: TActBasForm;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM;

procedure TActBasForm.FecharAction_ActBasFormExecute(Sender: TObject);
begin
  inherited;
  FecheForm;
end;

procedure TActBasForm.FecheForm;
begin
  Close;
end;

procedure TActBasForm.FormCreate(Sender: TObject);
begin
  inherited;
  if not Assigned(SisImgDataModule) then
    SisImgDataModule := TSisImgDataModule.Create(Application);
end;

end.
