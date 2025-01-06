unit Sis.Types.Dates;

interface

uses System.Classes;

function GetValidDate(pDate: TDateTIme): TDateTIme;

function ConvertGMTToTDateTime(const GMT: string): TDateTIme;
function ConvertTDateTimeToGMT(const DT: TDateTIme): string;
function ConvertGMTToTDateTimeStr(const GMT: string): string;
function DateTimeToSaudacao(const pDtH: TDateTIme): string;
function ConvertISO8601ToTDateTimeStr(const GMT: string): string;

function DataSQLFirebird(pD: tdate): string;
function DataHoraSQLFirebird(pD: TDateTIme): string;

function HoraSQLFirebird(pD: TDateTIme): string;
function NowSQLFirebird: string;

function VarToDateTime(Value: Variant): TDateTime;

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
  // sleep(10);
  Result := DataHoraSQLFirebird(now);
end;

function VarToDateTime(Value: Variant): TDateTime;
begin
  if VarIsNull(Value) or VarIsEmpty(Value) then
    Result := 2 // StrToDate('01/01/1900')
  else
    Result := Value;
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
