unit Sis.UI.Form.Bas.TabSheet_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Act_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ComCtrls;

type
  TTabSheetBasForm = class(TActBasForm)
    TitPanel_BasTabSheet: TPanel;
    TitToolBar1_BasTabSheet: TToolBar;
    FecharToolButton_BasTabSheet: TToolButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FFormClassNamesSL: TStringList;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList); reintroduce;
  end;

//  TTabSheetBasFormClass = class of TTabSheetBasForm;

var
  TabSheetBasForm: TTabSheetBasForm;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM;

{ TTabSheetBasForm }

constructor TTabSheetBasForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList);
begin
  inherited Create(AOwner);
  FFormClassNamesSL := pFormClassNamesSL;
  //DisparaShowTimer := True;
end;

procedure TTabSheetBasForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  iIndexExistente: integer;
begin
  inherited;
//  Action := TCloseAction.caFree;
  Action := TCloseAction.caNone;

  try
    iIndexExistente := FFormClassNamesSL.IndexOf(UpperCase(ClassName));
    if iIndexExistente>-1 then
      FFormClassNamesSL.Delete(iIndexExistente);

    Parent.Free;
  except

  end;
end;

end.
