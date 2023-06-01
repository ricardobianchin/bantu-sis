unit btu.sta.Form.Config;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.Imaging.pngimage, btu.sta.MaqNomeEdFrame,
  Vcl.ComCtrls, Vcl.ToolWin, System.Actions, Vcl.ActnList, btu.lib.config;

type
{
  TGroupBox = class(Vcl.StdCtrls.TGroupBox)
  public
    property AutoSize;
  end;
 }
  TStarterFormConfig = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Panel2: TPanel;
    CheckBox1: TCheckBox;
    LocalMaqNomeEdFrame: TMaqNomeEdFrame;
    ServerMaqNomeEdFrame: TMaqNomeEdFrame;
    ActionList1: TActionList;
    OkAct: TAction;
    CancelAct: TAction;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ReloadAct: TAction;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure OkActExecute(Sender: TObject);
    procedure CancelActExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FSisConfig: ISisConfig;
    function GetIsDataOk: boolean;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pSisConfig: ISisConfig); reintroduce;
  end;

var
  StarterFormConfig: TStarterFormConfig;

implementation

{$R *.dfm}

uses Math, ControlsReposition, btu.lib.ui.Img.DataModule,
  btu.lib.config.machineid, winapi.winsock;

procedure FillMachineId(ALocalMachineId: IMachineId);
var
  Buffer: array[0..MAX_COMPUTERNAME_LENGTH + 1] of Char;
  Size: DWORD;
  HostEnt: PHostEnt;
  WSAData: TWSAData;
begin
  // Get the computer name
  Size := Length(Buffer);
  if GetComputerName(Buffer, Size) then
    ALocalMachineId.Name := Buffer
  else
    ALocalMachineId.Name := '';

  // Get the IP address
  WSAStartup($101, WSAData);
  try
    HostEnt := gethostbyname(PAnsiChar(AnsiString(ALocalMachineId.Name)));
    if HostEnt <> nil then
      ALocalMachineId.IP := Format('%d.%d.%d.%d', [
        Byte(HostEnt^.h_addr^[0]),
        Byte(HostEnt^.h_addr^[1]),
        Byte(HostEnt^.h_addr^[2]),
        Byte(HostEnt^.h_addr^[3])
      ])
    else
      ALocalMachineId.IP := '';
  finally
    WSACleanup;
  end;
end;


procedure TStarterFormConfig.Button1Click(Sender: TObject);
begin

  FillMachineId(FSisConfig.LocalMachineId);
  LocalMaqNomeEdFrame.NomeLabeledEdit.Text := FSisConfig.LocalMachineId.Name;
  LocalMaqNomeEdFrame.IpLabeledEdit.Text := FSisConfig.LocalMachineId.IP;
end;

procedure TStarterFormConfig.CancelActExecute(Sender: TObject);
begin
  modalresult := mrCancel;
end;

constructor TStarterFormConfig.Create(AOwner: TComponent;
  pSisConfig: ISisConfig);
begin
  inherited Create(AOwner);
  FSisConfig := pSisConfig;
end;

procedure TStarterFormConfig.FormCreate(Sender: TObject);
begin
  LocalMaqNomeEdFrame.GroupBox1.Caption := 'Máquina Local';
//  LocalGroupBox.AutoSize := true;
//  ServerGroupBox.AutoSize := true;
end;

procedure TStarterFormConfig.FormResize(Sender: TObject);
begin
//  RepositionControls( LocalGroupBox, 9, 35);
//  LocalGroupBox.Width := FlowPanel1.Width;
//  LocalGroupBox.Width := Panel2.Width;
//  if FlowPanel2.Height>LocalGroupBox.Height then
//  LocalGroupBox.Height := FlowPanel2.Height+10;
end;

function TStarterFormConfig.GetIsDataOk: boolean;
begin
  result := FSisConfig.LocalMachineId.IsDataOk;

end;

procedure TStarterFormConfig.OkActExecute(Sender: TObject);
begin
  if not GetIsDataOk then
    exit;

  modalresult := mrOk;
end;

end.
