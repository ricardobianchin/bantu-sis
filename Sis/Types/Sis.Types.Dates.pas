unit Sis.Types.Dates;

interface

uses System.Classes, Sis.Sis.Constants;

function GetValidDate(pDate: TDateTIme): TDateTIme;

function ConvertGMTToTDateTime(const GMT: string): TDateTIme;
function ConvertTDateTimeToGMT(const DT: TDateTIme): string;
function ConvertGMTToTDateTimeStr(const GMT: string): string;
function DateTimeToSaudacao(const pDtH: TDateTIme): string;
function ConvertISO8601ToTDateTimeStr(const GMT: string): string;

function TimeStampStrToDateTimeStr(const pTimeStampStr: string; pComMilisegundos: Boolean = False): string;
function TimeStampStrToDateTime(const pTimeStampStr: string): TDateTime;

function DataSQLFirebird(pD: tdate): string;
function DataHoraSQLFirebird(pD: TDateTIme): string;

function HoraSQLFirebird(pD: TDateTIme): string;
function NowSQLFirebird: string;

function VarToDateTime(Value: Variant): TDateTime;

function GetDtHString(pDtH: TDateTIme): string;
function GetAgoraString: string;

function GetPrimDiaMes(pDateTime: TDateTime = DATA_ZERADA): TDateTime;
function GetPrimDiaTrimestre(pDateTime: TDateTime = DATA_ZERADA): TDateTime;

procedure SetDtHRangePreviousMonth(out pInicial: TDateTIme; out pFinal: TDateTIme);
procedure SetDtHRangeThisMonth(out pInicial: TDateTIme; out pFinal: TDateTIme);
procedure SetDtHRangeToday(out pInicial: TDateTIme; out pFinal: TDateTIme);
procedure SetDtHRangeDays(out pInicial: TDateTIme; out pFinal: TDateTIme; ANumberOfDays: integer);
procedure SetDtHRangeLast30(out pInicial: TDateTIme; out pFinal: TDateTIme);

var
  MonthNames: TStringList;
  MascaraDate, MascaraTime: string;

implementation

uses Sis.Types.Bool_u, System.SysUtils, DateUtils, Winapi.Windows,
  Sis.Types.Integers, System.Variants;

function GetValidDate(pDate: TDateTIme): TDateTIme;
begin
  Result := Iif(pDate = 0, Date, pDate);
end;

function ConvertGMTToTDateTime(const GMT: string): TDateTIme;
var
  Day, Month, Year, Time: string;
  DT: TDateTIme;
  FormatSettings: TFormatSettings;
begin
  Day := Copy(GMT, 6, 2);
  Month := IntToStr(MonthNames.IndexOf(Copy(GMT, 9, 3)) + 1);
  Year := Copy(GMT, 13, 4);
  Time := Copy(GMT, 18, 8);

  FormatSettings := TFormatSettings.Create;
  FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
  FormatSettings.DateSeparator := '/';
  FormatSettings.LongTimeFormat := 'hh:nn:ss';

  DT := StrToDateTime(Day + '/' + Month + '/' + Year + ' ' + Time,
    FormatSettings);
  DT := IncHour(DT, -3); // Subtrai 3 horas

  Result := DT;
end;

function ConvertTDateTimeToGMT(const DT: TDateTIme): string;
var
  FormatSettings: TFormatSettings;
begin
  FormatSettings := TFormatSettings.Create;
  FormatSettings.ShortDateFormat := 'ddd, d mmm yyyy';
  FormatSettings.LongTimeFormat := 'hh:nn:ss';
  FormatSettings.DateSeparator := ' ';
  Result := DateTimeToStr(DT, FormatSettings);
end;

function ConvertGMTToTDateTimeStr(const GMT: string): string;
var
  Day, Month, Year, Time: string;
  DT: TDateTIme;
  FormatSettings: TFormatSettings;
  // myDate, myTime: string;
begin
  Day := Copy(GMT, 6, 2);
  Month := IntToStr(MonthNames.IndexOf(Copy(GMT, 9, 3)) + 1);
  Year := Copy(GMT, 13, 4);
  Time := Copy(GMT, 18, 8);

  FormatSettings := TFormatSettings.Create;
  FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
  FormatSettings.DateSeparator := '/';
  FormatSettings.LongTimeFormat := 'hh:nn:ss';

  DT := StrToDateTime(Day + '/' + Month + '/' + Year + ' ' + Time,
    FormatSettings);
  { if LowerCase(MascaraDate[1])='d' then
    DT := StrToDateTime(Day + '/' + Month + '/' + Year + ' ' + Time, FormatSettings)
    else
    DT := StrToDateTime( Month + '/' + Day + '/' +Year + ' ' + Time, FormatSettings)
  }
  DT := IncHour(DT, -3); // Subtrai 3 horas

  Result := DateTimeToStr(DT);
end;

function DateTimeToSaudacao(const pDtH: TDateTIme): string;
var
  iHora: Integer;
begin
  iHora := HourOf(pDtH);

  if iHora < 12 then
    Result := 'Bom dia!'
  else if iHora < 18 then
    Result := 'Boa tarde!'
  else
    Result := 'Boa noite!';
end;

function ConvertISO8601ToTDateTimeStr(const GMT: string): string;
var
  Day, Month, Year, Time: string;
  DT: TDateTIme;
  FormatSettings: TFormatSettings;
  sDtH: string;
  // sDeslocamento: string;
  // myDate, myTime: string;
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

function TimeStampStrToDateTimeStr(const pTimeStampStr: string; pComMilisegundos: Boolean): string;
begin
{
implemente a function TimeStampStrToDateTimeStr
ela recebe uma string no formato yyyy-mm-dd hh:nn:ss.zzzz
e retorna uma string no formato dd/mm/yyyy hh:nn:ss.zzz
por exemplo, se a string for '2025-02-22 10:14:41.4440'
a função deve retornar '22/02/2025 10:14:41.444'

yyyy-mm-dd hh:nn:ss.zzzz
2025-02-22 10:14:41.4440
122456789 123456789 123

se a function TimeStampStrToDateTimesTR receber o parametro
'2025-02-22 10:14:41.4440'
vai retornar
'22/02/2025 10:14:41'?
}
  Result := Copy(pTimeStampStr, 9, 2) //
    + '/' + Copy(pTimeStampStr, 6, 2) //
    + '/' + Copy(pTimeStampStr, 1, 4) //
    + ' ' + Copy(pTimeStampStr, 12, 2) //
    + ':' + Copy(pTimeStampStr, 15, 2) //
    + ':' + Copy(pTimeStampStr, 18, 2) //
    ;
  if pComMilisegundos then
    Result := Result + '.' + Copy(pTimeStampStr, 21, 3);
end;

function TimeStampStrToDateTime(const pTimeStampStr: string): TDateTime;
var
  Year, Month, Day, Hour, Minute, Second, MilliSecond: Word;
begin
{
2025-02-22 10:14:41.4440
122456789 123456789 123
}
  if Length(pTimeStampStr)=19 then
  begin
    Result := StrToDateTime(pTimeStampStr);
    exit;
  end;

  Year := StrToInt(Copy(pTimeStampStr, 1, 4));
  Month := StrToInt(Copy(pTimeStampStr, 6, 2));
  Day := StrToInt(Copy(pTimeStampStr, 9, 2));

  Hour := StrToInt(Copy(pTimeStampStr, 12, 2));
  Minute := StrToInt(Copy(pTimeStampStr, 15, 2));
  Second := StrToInt(Copy(pTimeStampStr, 18, 2));
  MilliSecond := StrToInt(Copy(pTimeStampStr, 21, 3));

  Result := EncodeDateTime(Year, Month, Day, Hour, Minute, Second, MilliSecond);
end;

function DataSQLFirebird(pD: tdate): string;
var
  d, m, a: word;
begin
  if pD = 0 then
  begin
    Result := 'NULL';
    exit;
  end;
  DecodeDate(pD, a, m, d);
  Result := QuotedStr(IntToStr(d) + '.' + IntToStr(m) + '.' + IntToStr(a));
end;

function DataHoraSQLFirebird(pD: TDateTIme): string;
var
  d, m, a, h, mm, s, ms: word;
begin
  DecodeDateTime(pD, a, m, d, h, mm, s, ms);
  Result := QuotedStr(IntToStr(d) + '.' + IntToStr(m) + '.' + IntToStr(a) + ' '
    + IntToStr(h) + ':' + IntToStr(mm) + ':' + IntToStr(s) + '.' +
    IntToStrZero(ms, 4));
end;

function HoraSQLFirebird(pD: TDateTIme): string;
var
  d, m, a, h, mm, s, ms: word;
begin
  DecodeDateTime(pD, a, m, d, h, mm, s, ms);
  Result := QuotedStr(IntToStr(h) + ':' + IntToStr(mm) + ':' + IntToStr(s) + '.'
    + IntToStrZero(ms, 4));
end;

function NowSQLFirebird: string;
begin
  Result := DataHoraSQLFirebird(now);
end;

function VarToDateTime(Value: Variant): TDateTime;
begin
  if VarIsNull(Value) or VarIsEmpty(Value) then
    Result := 2 // StrToDate('01/01/1900')
  else
    Result := Value;
end;

function GetDtHString(pDtH: TDateTIme): string;
begin
  Result := FormatDateTime('dd/mm/yyyy hh:nn', pDtH);
end;

function GetAgoraString: string;
begin
  Result := GetDtHString(now);
end;

function GetPrimDiaMes(pDateTime: TDateTime = DATA_ZERADA): TDateTime;
var
  Year, Month, Day: Word;
begin
  if pDateTime = DATA_ZERADA then
    pDateTime := Date;

  DecodeDate(pDateTime, Year, Month, Day);
  Day := 1;
  Result := EncodeDate(Year, Month, Day);
end;

function GetPrimDiaTrimestre(pDateTime: TDateTime = DATA_ZERADA): TDateTime;
var
  Year, Month, Day: Word;
begin
  if pDateTime = DATA_ZERADA then
    pDateTime := Date;

  DecodeDate(pDateTime, Year, Month, Day);

  // Calcula o mês inicial do trimestre
  Month := ((Month - 1) div 3) * 3 + 1;

  // Retorna o primeiro dia do trimestre
  Result := EncodeDate(Year, Month, 1);
end;

procedure SetDtHRangePreviousMonth(out pInicial: TDateTime; out pFinal: TDateTime);
var
  Year, Month, Day: Word;
  CurrentDate: TDateTime;
begin
  pFinal := GetPrimDiaMes;
  pFinal := IncSecond(pFinal, -1);

  pInicial := GetPrimDiaMes(pFinal);
end;

procedure SetDtHRangeThisMonth(out pInicial: TDateTIme; out pFinal: TDateTIme);
begin
  pFinal := Date + 1;
  pFinal := IncSecond(pFinal, -1);
  pInicial := GetPrimDiaMes(pFinal);

end;

procedure SetDtHRangeToday(out pInicial: TDateTIme; out pFinal: TDateTIme);
begin
  pInicial := Date;
  pFinal := pInicial + 1;
  pFinal := IncSecond(pFinal, -1);
end;

procedure SetDtHRangeDays(out pInicial: TDateTIme; out pFinal: TDateTIme; ANumberOfDays: integer);
begin
  pFinal := Date + 1;
  pInicial := pFinal - (ANumberOfDays + 1);
  pFinal := IncSecond(pFinal, -1);
end;

procedure SetDtHRangeLast30(out pInicial: TDateTIme; out pFinal: TDateTIme);
begin
  pFinal := Date;
  pInicial := IncMonth(pFinal, -1);
  pFinal := pFinal + 1;
  pFinal := IncSecond(pFinal, -1);
end;

initialization

var
  iniFormatSettings: TFormatSettings;
iniFormatSettings := TFormatSettings.Create;

MonthNames := TStringList.Create;
MonthNames.CommaText :=
  '"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"';

// MascaraDate := GetLocaleStr(GetThreadLocale(), LOCALE_SSHORTDATE, '');
// MascaraTime := GetLocaleStr(GetThreadLocale(), LOCALE_STIMEFORMAT, '');

MascaraDate := FormatSettings.ShortDateFormat;
MascaraTime := FormatSettings.LongTimeFormat;

finalization

MonthNames.Free;

end.
