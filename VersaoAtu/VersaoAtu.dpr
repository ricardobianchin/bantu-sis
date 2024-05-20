program VersaoAtu;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils, System.DateUtils, System.Classes,
  VersaoAtu.SrcAtu_u in 'SrcAtu\VersaoAtu.SrcAtu_u.pas',
  VersaoAtu.IssAtu_u in 'IssAtu\VersaoAtu.IssAtu_u.pas';

const
  NomeArqDescribeTxt = 'C:\Pr\app\bantu\bantu-sis\Controle\sis.git.describe.txt';

var
  sDescribe: string;
  sISO8601DtH: string;
  sHash: string;
  sDtH: string;

function ConvertISO8601ToTDateTimeStr(const GMT: string): string;
var
  Day, Month, Year, Time: string;
  DT: TDateTime;
  FormatSettings: TFormatSettings;
  sDtH: string;
//  sDeslocamento: string;
  //myDate, myTime: string;
begin
  Day := Copy(GMT, 9, 2);
  Month := Copy(GMT, 6, 2);
  Year := Copy(GMT, 1, 4);
  Time := Copy(GMT, 12, 8);

  sDtH := Day + '/' + Month + '/' + Year + ' ' + Time;

  FormatSettings := TFormatSettings.Create;
  FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
  FormatSettings.DateSeparator := '/';
  FormatSettings.LongTimeFormat := 'hh:nn:ss';

  DT := StrToDateTime(sDtH, FormatSettings);
  DT := IncHour(DT, -3); // Subtrai 3 horas

  Result := DateTimeToStr(DT);
end;

procedure LeiaStdIn;
begin
  ReadLn(sDescribe);
  ReadLn(sISO8601DtH);
  ReadLn(sHash);
end;

procedure LeiaDescribeTxt;
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    sl.LoadFromFile(NomeArqDescribeTxt);

    sDescribe := sl[0];
    sISO8601DtH := sl[1];
    sHash := sl[2];
  finally
    sl.Free;
  end;
end;

begin
  try
    //LeiaStdIn;
    LeiaDescribeTxt;
    sDtH := ConvertISO8601ToTDateTimeStr(sISO8601DtH);
    SrcAtuExecute(sDescribe, sDtH, sHash);
    IssAtuExecute(sDescribe, sDtH);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
