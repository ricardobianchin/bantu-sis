unit App.UI.Form.Bas.Ed_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas.Diag.Btn_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Data.DB;

type
  TEdBasForm = class(TDiagBtnBasForm)
  private
    { Private declarations }
    FState: TDataSetState;
    FTitulo: string;
    function GetTitulo: string;

  protected
    function GetState: TDataSetState;
    procedure SetState(Value: TDataSetState);
    property State: TDataSetState read GetState write SetState;

    property Titulo: string read GetTitulo;

    procedure AtuExib; virtual;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pTitulo: string;
      pState: TDataSetState); reintroduce;
  end;

var
  EdBasForm: TEdBasForm;

implementation

{$R *.dfm}

uses App.DB.Utils;

{ TEdBasForm }

procedure TEdBasForm.AtuExib;
var
  sCaption: string;
  sTitulo, sState: string;
begin
  sTitulo := GetTitulo;
  sState := DataSetStateToTitulo(FState);
  sCaption := Format('%s - %s', [sTitulo, sState]);
  Caption := sCaption;
end;

constructor TEdBasForm.Create(AOwner: TComponent; pTitulo: string;
  pState: TDataSetState);
begin
  inherited Create(AOwner);
  FState := pState;
end;

function TEdBasForm.GetState: TDataSetState;
begin
  Result := FState;
end;

function TEdBasForm.GetTitulo: string;
begin
  Result := FTitulo;
end;

procedure TEdBasForm.SetState(Value: TDataSetState);
begin
  FState := Value;
  AtuExib;
end;

end.
