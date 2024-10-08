unit Sis.UI.Controls.BotaoFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, Vcl.ExtCtrls,
  Vcl.StdCtrls, System.UITypes;

type
  TBotaoFrame = class(TBasFrame)
    FundoPanel: TPanel;
    IconPanel: TPanel;
    IconImage: TImage;
    TitLabel: TLabel;
    Tit2Label: TLabel;
  private
    { Private declarations }
    FImageIndex: TImageIndex;
    FOnBotaoClick: TNotifyEvent;
    FShortCut: TShortCut;

    function GetImageIndex: TImageIndex;
    function GetTit: string;
    procedure SetTit(const Value: string);
    function GetTit2: string;
    procedure SetTit2(const Value: string);
    function GetOnBotaoClick: TNotifyEvent;
    procedure SetOnBotaoClick(const Value: TNotifyEvent);
  protected
    procedure SetImageIndex(Value: TImageIndex); virtual;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property ImageIndex: TImageIndex read GetImageIndex write SetImageIndex;
    property Tit: string read GetTit write SetTit;
    property Tit2: string read GetTit2 write SetTit2;
    property OnBotaoClick: TNotifyEvent read GetOnBotaoClick write SetOnBotaoClick;
    property ShortCut: TShortCut read FShortCut write FShortCut;
  end;

var
  BotaoFrame: TBotaoFrame;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils;

{ TBotaoModuloFrame }

constructor TBotaoFrame.Create(AOwner: TComponent);
begin
  inherited;
  SetCursorToChilds(Self, crHandPoint);
//  ClearStyleElements(Self);
end;

function TBotaoFrame.GetTit: string;
begin
  Result := TitLabel.Caption;
end;

function TBotaoFrame.GetTit2: string;
begin
  Result := Tit2Label.Caption;
end;

function TBotaoFrame.GetImageIndex: TImageIndex;
begin
  Result := FImageIndex;
end;

function TBotaoFrame.GetOnBotaoClick: TNotifyEvent;
begin
  Result := FOnBotaoClick;
end;

procedure TBotaoFrame.SetTit(const Value: string);
begin
  TitLabel.Caption := Value;
end;

procedure TBotaoFrame.SetTit2(const Value: string);
begin
  Tit2Label.Caption := Value;
end;

procedure TBotaoFrame.SetImageIndex(Value: TImageIndex);
begin
  FImageIndex := Value;
end;

procedure TBotaoFrame.SetOnBotaoClick(const Value: TNotifyEvent);
begin
  FOnBotaoClick := Value;
  SetOnClickToChilds(Self, Value);
end;

end.
