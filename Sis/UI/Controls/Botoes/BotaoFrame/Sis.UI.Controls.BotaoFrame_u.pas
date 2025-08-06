unit Sis.UI.Controls.BotaoFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, Vcl.ExtCtrls,
  Vcl.StdCtrls, System.UITypes, System.ImageList, Vcl.ImgList;

type
  TBotaoFrame = class(TBasFrame)
    FundoPanel: TPanel;
    IconPanel: TPanel;
    IconImage: TImage;
    TitLabel: TLabel;
    Tit2Label: TLabel;
  private
    { Private declarations }
    FShortCut: TShortCut;
    FImageList: TCustomImageList;

    FImageIndex: System.UITypes.TImageIndex;

    FImageIndexMouseDown: System.UITypes.TImageIndex;
    FImageIndexMouseEnter: System.UITypes.TImageIndex;

    FOnBotaoClick: TNotifyEvent;
    FOnBotaoMouseDown: TMouseEvent;
    FOnBotaoMouseUp: TMouseEvent;
    FOnBotaoMouseEnter: TNotifyEvent;
    FOnBotaoMouseLeave: TNotifyEvent;

    function GetImageIndex: System.UITypes.TImageIndex;
    function GetImageIndexMouseDown: System.UITypes.TImageIndex;
    function GetImageIndexMouseEnter: System.UITypes.TImageIndex;

    procedure SetImageIndexMouseDown(Value: System.UITypes.TImageIndex);
    procedure SetImageIndexMouseEnter(Value: System.UITypes.TImageIndex);

    function GetTit: string;
    procedure SetTit(const Value: string);
    function GetTit2: string;
    procedure SetTit2(const Value: string);

    function GetOnBotaoClick: TNotifyEvent;
    function GetOnBotaoMouseDown: TMouseEvent;
    function GetOnBotaoMouseUp: TMouseEvent;
    function GetOnBotaoMouseEnter: TNotifyEvent;
    function GetOnBotaoMouseLeave: TNotifyEvent;

    procedure SetOnBotaoClick(const Value: TNotifyEvent);
    procedure SetOnBotaoMouseDown(const Value: TMouseEvent);
    procedure SetOnBotaoMouseUp(const Value: TMouseEvent);
    procedure SetOnBotaoMouseEnter(const Value: TNotifyEvent);
    procedure SetOnBotaoMouseLeave(const Value: TNotifyEvent);

  protected
    procedure SetImageIndex(Value: System.UITypes.TImageIndex); virtual;

    procedure BotaoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); virtual;
    procedure BotaoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); virtual;
    procedure BotaoMouseEnter(Sender: TObject); virtual;
    procedure BotaoMouseLeave(Sender: TObject); virtual;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property ImageIndex: System.UITypes.TImageIndex read GetImageIndex
      write SetImageIndex;
    property ImageIndexMouseDown: System.UITypes.TImageIndex
      read GetImageIndexMouseDown write SetImageIndexMouseDown;
    property ImageIndexMouseEnter: System.UITypes.TImageIndex
      read GetImageIndexMouseEnter write SetImageIndexMouseEnter;

    property Tit: string read GetTit write SetTit;
    property Tit2: string read GetTit2 write SetTit2;
    property OnBotaoClick: TNotifyEvent read GetOnBotaoClick
      write SetOnBotaoClick;
    property OnBotaoMouseDown: TMouseEvent read GetOnBotaoMouseDown
      write SetOnBotaoMouseDown;
    property OnBotaoMouseUp: TMouseEvent read GetOnBotaoMouseUp
      write SetOnBotaoMouseUp;
    property OnBotaoMouseEnter: TNotifyEvent read GetOnBotaoMouseEnter
      write SetOnBotaoMouseEnter;
    property OnBotaoMouseLeave: TNotifyEvent read GetOnBotaoMouseLeave
      write SetOnBotaoMouseLeave;
    property ShortCut: TShortCut read FShortCut write FShortCut;
    property ImageList: TCustomImageList read FImageList write FImageList;

    procedure BotaoClick;
  end;

var
  BotaoFrame: TBotaoFrame;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils;

{ TBotaoModuloFrame }

procedure TBotaoFrame.BotaoClick;
begin
  if not Assigned(FOnBotaoClick) then
    exit;

  FOnBotaoClick(Self);
end;

procedure TBotaoFrame.BotaoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TBotaoFrame.BotaoMouseEnter(Sender: TObject);
begin
end;

procedure TBotaoFrame.BotaoMouseLeave(Sender: TObject);
begin
end;

procedure TBotaoFrame.BotaoMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
end;

constructor TBotaoFrame.Create(AOwner: TComponent);
begin
  inherited;
  SetCursorToChilds(Self, crHandPoint);

  FOnBotaoMouseDown := BotaoMouseDown;
  FOnBotaoMouseUp := BotaoMouseUp;
  FOnBotaoMouseEnter := BotaoMouseEnter;
  FOnBotaoMouseLeave := BotaoMouseLeave;

  SetOnMouseDownToChilds(self, FOnBotaoMouseDown);
  SetOnMouseUpToChilds(self, FOnBotaoMouseUp);
  SetOnMouseEnterToChilds(self, FOnBotaoMouseEnter);
  SetOnMouseLeaveToChilds(self, FOnBotaoMouseLeave);

  // ClearStyleElements(Self);
end;

function TBotaoFrame.GetTit: string;
begin
  Result := TitLabel.Caption;
end;

function TBotaoFrame.GetTit2: string;
begin
  Result := Tit2Label.Caption;
end;

function TBotaoFrame.GetImageIndex: System.UITypes.TImageIndex;
begin
  Result := FImageIndex;
end;

function TBotaoFrame.GetImageIndexMouseDown: System.UITypes.TImageIndex;
begin
  Result := FImageIndexMouseDown;
end;

function TBotaoFrame.GetImageIndexMouseEnter: System.UITypes.TImageIndex;
begin
  Result := FImageIndexMouseEnter;
end;

function TBotaoFrame.GetOnBotaoClick: TNotifyEvent;
begin
  Result := FOnBotaoClick;
end;

function TBotaoFrame.GetOnBotaoMouseDown: TMouseEvent;
begin
  Result := FOnBotaoMouseDown;
end;

function TBotaoFrame.GetOnBotaoMouseEnter: TNotifyEvent;
begin
  Result := FOnBotaoMouseEnter;
end;

function TBotaoFrame.GetOnBotaoMouseLeave: TNotifyEvent;
begin
  Result := FOnBotaoMouseLeave;
end;

function TBotaoFrame.GetOnBotaoMouseUp: TMouseEvent;
begin
  Result := FOnBotaoMouseUp;
end;

procedure TBotaoFrame.SetTit(const Value: string);
begin
  TitLabel.Caption := Value;
end;

procedure TBotaoFrame.SetTit2(const Value: string);
begin
  Tit2Label.Caption := Value;
end;

procedure TBotaoFrame.SetImageIndex(Value: System.UITypes.TImageIndex);
begin
  FImageIndex := Value;
end;

procedure TBotaoFrame.SetImageIndexMouseDown(Value: System.UITypes.TImageIndex);
begin
  FImageIndexMouseDown := Value;
end;

procedure TBotaoFrame.SetImageIndexMouseEnter
  (Value: System.UITypes.TImageIndex);
begin
  FImageIndexMouseEnter := Value;
end;

procedure TBotaoFrame.SetOnBotaoClick(const Value: TNotifyEvent);
begin
  FOnBotaoClick := Value;
  SetOnClickToChilds(Self, Value);
end;

procedure TBotaoFrame.SetOnBotaoMouseDown(const Value: TMouseEvent);
begin
  FOnBotaoMouseDown := Value;
  SetOnMouseDownToChilds(Self, Value);
end;

procedure TBotaoFrame.SetOnBotaoMouseEnter(const Value: TNotifyEvent);
begin
  FOnBotaoMouseEnter := Value;
  SetOnMouseEnterToChilds(Self, Value);
end;

procedure TBotaoFrame.SetOnBotaoMouseLeave(const Value: TNotifyEvent);
begin
  FOnBotaoMouseLeave := Value;
  SetOnMouseLeaveToChilds(Self, Value);
end;

procedure TBotaoFrame.SetOnBotaoMouseUp(const Value: TMouseEvent);
begin
  FOnBotaoMouseUp := Value;
  SetOnMouseUpToChilds(Self, Value);
end;

end.
