unit App.DB.Term.Carga.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, Vcl.StdCtrls,
  Vcl.Buttons, App.AppObj;

type
  TTermCargaFrameFrame = class(TBasFrame)
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    FAppObj: IAppObj;
    procedure PreenchaConectionList;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj); reintroduce; virtual;
  end;

var
  TermCargaFrameFrame: TTermCargaFrameFrame;

implementation

{$R *.dfm}

procedure TTermCargaFrameFrame.BitBtn1Click(Sender: TObject);
begin
  inherited;
showmessage('a');
end;

constructor TTermCargaFrameFrame.Create(AOwner: TComponent; pAppObj: IAppObj);
begin
  inherited Create(AOwner);
  FAppObj := pAppObj;
  PreenchaConectionList;
end;

procedure TTermCargaFrameFrame.PreenchaConectionList;
begin

end;

end.
