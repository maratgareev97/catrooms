<?xml version="1.0" encoding="UTF-8"?>
<sch:schema queryBinding="xslt2" xmlns:sch="http://purl.oclc.org/dsdl/schematron"
            xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
            xmlns:xs="http://www.w3.org/2001/XMLSchema"
            xmlns:go="http://go.platformaofd.ru/xml/ns">

    <sch:ns prefix="go" uri="http://go.platformaofd.ru/xml/ns" />

    <xsl:function name="go:safe-number" as="xs:double">
        <xsl:param name="src" as="xs:string?"/>
        <xsl:sequence select="if (empty($src)) then 0 else number($src)"/>
    </xsl:function>

    <xsl:function name="go:safe-string" as="xs:string">
        <xsl:param name="src" as="xs:string?"/>
        <xsl:sequence select="if (empty($src)) then '' else $src"/>
    </xsl:function>
<!--
    <xsl:function name="go:one-of" as="xs:string">
        <xsl:param name="src1" as="xs:string?"/>
        <xsl:param name="src2" as="xs:string?"/>
        <xsl:sequence select="if (empty($src1)) then $src2 else $src1"/>
    </xsl:function>
-->

<xsl:function name="go:one-of" as="xs:string">
    <xsl:param name="src1" as="xs:string?"/>
    <xsl:param name="src2" as="xs:string?"/>
    <xsl:choose>
        <xsl:when test="not(empty($src1))">
            <xsl:sequence select="$src1"/>
        </xsl:when>
        <xsl:when test="not(empty($src2))">
            <xsl:sequence select="$src2"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:message terminate="yes">Оба параметра go:one-of пусты!</xsl:message>
        </xsl:otherwise>
    </xsl:choose>
</xsl:function>

    <xsl:function name="go:parse-date" as="xs:date">
        <xsl:param name="src" as="xs:string?"/>
        <xsl:sequence select="if (empty($src)) then current-date() else xs:date(concat(substring($src,7,4), '-', substring($src,4,2), '-', substring($src,1,2)))"/>
    </xsl:function>

    <xsl:function name="go:format-date" as="xs:string">
        <xsl:param name="src" as="xs:date?"/>
        <xsl:sequence select="format-date($src, '[D,2].[M,2].[Y]')"/>
    </xsl:function>

    <sch:pattern name="УЕНП-КБК">
        <sch:rule context="Документ/УвИсчСумНалог/@КБК">
            <sch:let name="inn" value="go:one-of(../../СвНП/НПЮЛ/@ИННЮЛ, ../../СвНП/НПИП/@ИННФЛ)"/>
            <sch:let name="kpp" value="../@КППДекл"/>
            <sch:let name="month" value="go:safe-string(../@НомерМесКварт)"/>
            <sch:let name="year" value="go:safe-string(../@Год)"/>
            <sch:let name="period" value="go:safe-string(../@Период)"/>
            <sch:let name="fullPeriod" value="concat($period, '/', $month)"/>
            <sch:let name="docDate" value="go:parse-date(../../@ДатаДок)"/>
            <sch:let name="jan01" value="xs:date(concat(string($year), '-01-01'))"/>
            <sch:let name="jan23" value="xs:date(concat(string($year), '-01-23'))"/>
            <sch:let name="feb01" value="xs:date(concat(string($year), '-02-01'))"/>
            <sch:let name="feb23" value="xs:date(concat(string($year), '-02-23'))"/>
            <sch:let name="mar01" value="xs:date(concat(string($year), '-03-01'))"/>
            <sch:let name="mar23" value="xs:date(concat(string($year), '-03-23'))"/>
            <sch:let name="apr01" value="xs:date(concat(string($year), '-04-01'))"/>
            <sch:let name="apr23" value="xs:date(concat(string($year), '-04-23'))"/>
            <sch:let name="may01" value="xs:date(concat(string($year), '-05-01'))"/>
            <sch:let name="may23" value="xs:date(concat(string($year), '-05-23'))"/>
            <sch:let name="jun01" value="xs:date(concat(string($year), '-06-01'))"/>
            <sch:let name="jun23" value="xs:date(concat(string($year), '-06-23'))"/>
            <sch:let name="jul01" value="xs:date(concat(string($year), '-07-01'))"/>
            <sch:let name="jul23" value="xs:date(concat(string($year), '-07-23'))"/>
            <sch:let name="aug01" value="xs:date(concat(string($year), '-08-01'))"/>
            <sch:let name="aug23" value="xs:date(concat(string($year), '-08-23'))"/>
            <sch:let name="sep01" value="xs:date(concat(string($year), '-09-01'))"/>
            <sch:let name="sep23" value="xs:date(concat(string($year), '-09-23'))"/>
            <sch:let name="oct01" value="xs:date(concat(string($year), '-10-01'))"/>
            <sch:let name="oct23" value="xs:date(concat(string($year), '-10-23'))"/>
            <sch:let name="nov01" value="xs:date(concat(string($year), '-11-01'))"/>
            <sch:let name="nov23" value="xs:date(concat(string($year), '-11-23'))"/>
            <sch:let name="dec01" value="xs:date(concat(string($year), '-12-01'))"/>
            <sch:let name="dec23" value="xs:date(concat(string($year), '-12-23'))"/>

            <sch:assert test="empty($kpp) or $kpp = '0' or contains('18210101040011000110, 18210101070011000110, 18210101030011000110, 18210101050011000110, 18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210201000011000160, 18210204010011010160, 18210204010011020160, 18210204020011010160, 18210204020011020160, 18210208000061000160, 18210209000061000160, 18210210000011000160, 18210211000011000160, 18210602010021000110, 18210602020021000110, 18210604011021000110, 18210606031031000110, 18210606032041000110, 18210606032111000110, 18210606032121000110, 18210606032141000110, 18210606033051000110, 18210606033101000110, 18210606033131000110, 18210501011011000110, 18210501021011000110, 18210503010011000110, 18210215010061000160, 18210215020061000160, 18210215030081000160, 18210102010011010110, 18210102080011010110', current())" role="WARNING">
                Недопустимый КБК для юридического лица (КС-2).
            </sch:assert>
            <sch:assert test="(not(empty($kpp)) and $kpp != '0') or contains('18210101040011000110, 18210101050011000110, 18210102010011000110, 18210102020011000110, 18210102080011000110, 18210201000011000160, 18210204010011010160, 18210204010011020160, 18210204020011010160, 18210204020011020160, 18210208000061000160, 18210209000061000160, 18210501011011000110, 18210501021011000110, 18210503010011000110, 18210215010061000160, 18210215020061000160, 18210215030081000160, 18210101030011000110', current())" role="WARNING">
                Недопустимый КБК для ИП <sch:value-of select="$kpp"/> (КС-3).
            </sch:assert>

            <!-- КС 5-13 -->

            <sch:assert test="(not(contains('18210101030011000110, 18210101050011000110', current()))) or ($fullPeriod != '21/01') or ($docDate >= $jan01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($jan01)"/> (КС-5).
            </sch:assert>
            <sch:assert test="(not(contains('18210101030011000110, 18210101050011000110', current()))) or ($fullPeriod != '21/02') or ($docDate >= $feb01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($feb01)"/> (КС-6).
            </sch:assert>
            <sch:assert test="(not(contains('18210101030011000110, 18210101050011000110', current()))) or ($fullPeriod != '31/01') or ($docDate >= $apr01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($apr01)"/> (КС-7).
            </sch:assert>
            <sch:assert test="(not(contains('18210101030011000110, 18210101050011000110', current()))) or ($fullPeriod != '31/02') or ($docDate >= $may01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($may01)"/> (КС-8).
            </sch:assert>
            <sch:assert test="(not(contains('18210101030011000110, 18210101050011000110', current()))) or ($fullPeriod != '33/01') or ($docDate >= $jul01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($jul01)"/> (КС-9).
            </sch:assert>
            <sch:assert test="(not(contains('18210101030011000110, 18210101050011000110', current()))) or ($fullPeriod != '33/02') or ($docDate >= $aug01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($aug01)"/> (КС-10).
            </sch:assert>
            <sch:assert test="(not(contains('18210101030011000110, 18210101050011000110', current()))) or ($fullPeriod != '34/01') or ($docDate >= $oct01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($oct01)"/> (КС-11).
            </sch:assert>
            <sch:assert test="(not(contains('18210101030011000110, 18210101050011000110', current()))) or ($fullPeriod != '34/02') or ($docDate >= $nov01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($nov01)"/> (КС-12).
            </sch:assert>
            <sch:assert test="(not(contains('18210101030011000110, 18210101050011000110', current()))) or ($fullPeriod != '34/03') or ($docDate >= $dec01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($dec01)"/> (КС-13).
            </sch:assert>

            <!-- КС 14-22 -->

            <sch:assert test="(not(contains('18210101040011000110, 18210101070011000110', current()))) or ($fullPeriod != '21/01') or ($docDate >= $jan01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($jan01)"/> (КС-14).
            </sch:assert>
            <sch:assert test="(not(contains('18210101040011000110, 18210101070011000110', current()))) or ($fullPeriod != '21/02') or ($docDate >= $feb01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($feb01)"/> (КС-15).
            </sch:assert>
            <sch:assert test="(not(contains('18210101040011000110, 18210101070011000110', current()))) or ($fullPeriod != '31/01') or ($docDate >= $apr01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($apr01)"/> (КС-16).
            </sch:assert>
            <sch:assert test="(not(contains('18210101040011000110, 18210101070011000110', current()))) or ($fullPeriod != '31/02') or ($docDate >= $may01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($may01)"/> (КС-17).
            </sch:assert>
            <sch:assert test="(not(contains('18210101040011000110, 18210101070011000110', current()))) or ($fullPeriod != '33/01') or ($docDate >= $jul01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($jul01)"/> (КС-18).
            </sch:assert>
            <sch:assert test="(not(contains('18210101040011000110, 18210101070011000110', current()))) or ($fullPeriod != '33/02') or ($docDate >= $aug01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($aug01)"/> (КС-19).
            </sch:assert>
            <sch:assert test="(not(contains('18210101040011000110, 18210101070011000110', current()))) or ($fullPeriod != '34/01') or ($docDate >= $oct01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($oct01)"/> (КС-20).
            </sch:assert>
            <sch:assert test="(not(contains('18210101040011000110, 18210101070011000110', current()))) or ($fullPeriod != '34/02') or ($docDate >= $nov01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($nov01)"/> (КС-21).
            </sch:assert>
            <sch:assert test="(not(contains('18210101040011000110, 18210101070011000110', current()))) or ($fullPeriod != '34/03') or ($docDate >= $dec01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($dec01)"/> (КС-22).
            </sch:assert>

            <!-- КС 23-46 -->

            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '21/01') or ($docDate >= $jan01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($jan01)"/> (КС-23).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '21/11') or ($docDate >= $jan23)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($jan23)"/> (КС-24).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '21/02') or ($docDate >= $feb01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($feb01)"/> (КС-25).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '21/12') or ($docDate >= $feb23)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($feb23)"/> (КС-26).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '21/03') or ($docDate >= $mar01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($mar01)"/> (КС-27).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '21/13') or ($docDate >= $mar23)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($mar23)"/> (КС-28).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '31/01') or ($docDate >= $apr01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($apr01)"/> (КС-29).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '31/11') or ($docDate >= $apr23)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($apr23)"/> (КС-30).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '31/02') or ($docDate >= $may01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($may01)"/> (КС-31).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '31/12') or ($docDate >= $may23)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($may23)"/> (КС-32).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '31/03') or ($docDate >= $jun01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($jun01)"/> (КС-33).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '31/13') or ($docDate >= $jun23)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($jun23)"/> (КС-34).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '33/01') or ($docDate >= $jul01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($jul01)"/> (КС-35).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '33/11') or ($docDate >= $jul23)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($jul23)"/> (КС-36).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '33/02') or ($docDate >= $aug01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($aug01)"/> (КС-37).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '33/12') or ($docDate >= $aug23)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($aug23)"/> (КС-38).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '33/03') or ($docDate >= $sep01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($sep01)"/> (КС-39).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '33/13') or ($docDate >= $sep23)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($sep23)"/> (КС-40).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '34/01') or ($docDate >= $oct01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($oct01)"/> (КС-41).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '34/11') or ($docDate >= $oct23)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($oct23)"/> (КС-42).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '34/02') or ($docDate >= $nov01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($nov01)"/> (КС-43).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '34/12') or ($docDate >= $nov23)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($nov23)"/> (КС-44).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '34/03') or ($docDate >= $dec01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($dec01)"/> (КС-45).
            </sch:assert>
            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', current()))) or ($fullPeriod != '34/13') or ($docDate >= $dec23)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($dec23)"/> (КС-46).
            </sch:assert>

            <!-- КС 47-49 -->

            <sch:assert test="(not(contains('18210102020011000110', current()))) or ($fullPeriod != '21/04') or ($docDate >= $apr01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($apr01)"/> (КС-47).
            </sch:assert>
            <sch:assert test="(not(contains('18210102020011000110', current()))) or ($fullPeriod != '31/04') or ($docDate >= $jul01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($jul01)"/> (КС-48).
            </sch:assert>
            <sch:assert test="(not(contains('18210102020011000110', current()))) or ($fullPeriod != '33/04') or ($docDate >= $oct01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($oct01)"/> (КС-49).
            </sch:assert>

            <!-- КС 50-52 -->

            <sch:assert test="(not(contains('18210102080011000110', current()))) or (string-length($inn) != 12) or ($fullPeriod != '21/04') or ($docDate >= $apr01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($apr01)"/> (КС-50).
            </sch:assert>
            <sch:assert test="(not(contains('18210102080011000110', current()))) or (string-length($inn) != 12) or ($fullPeriod != '31/04') or ($docDate >= $jul01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($jul01)"/> (КС-51).
            </sch:assert>
            <sch:assert test="(not(contains('18210102080011000110', current()))) or (string-length($inn) != 12) or ($fullPeriod != '33/04') or ($docDate >= $oct01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($oct01)"/> (КС-52).
            </sch:assert>

            <!-- КС 53-64 -->

            <sch:assert test="(not(contains('18210201000011000160, 18210209000061000160, 18210208000061000160, 18210204010011010160, 18210204010011020160, 18210204020011010160, 18210204020011020160, 18210210000011000160, 18210211000011000160, 18210215010061000160, 18210215020061000160, 18210215030081000160', current()))) or ($fullPeriod != '21/01') or ($docDate >= $jan01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($jan01)"/> (КС-53).
            </sch:assert>
            <sch:assert test="(not(contains('18210201000011000160, 18210209000061000160, 18210208000061000160, 18210204010011010160, 18210204010011020160, 18210204020011010160, 18210204020011020160, 18210210000011000160, 18210211000011000160, 18210215010061000160, 18210215020061000160, 18210215030081000160', current()))) or ($fullPeriod != '21/02') or ($docDate >= $feb01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($feb01)"/> (КС-54).
            </sch:assert>
            <sch:assert test="(not(contains('18210201000011000160, 18210209000061000160, 18210208000061000160, 18210204010011010160, 18210204010011020160, 18210204020011010160, 18210204020011020160, 18210210000011000160, 18210211000011000160, 18210215010061000160, 18210215020061000160, 18210215030081000160', current()))) or ($fullPeriod != '21/03') or ($docDate >= $mar01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($mar01)"/> (КС-55).
            </sch:assert>
            <sch:assert test="(not(contains('18210201000011000160, 18210209000061000160, 18210208000061000160, 18210204010011010160, 18210204010011020160, 18210204020011010160, 18210204020011020160, 18210210000011000160, 18210211000011000160, 18210215010061000160, 18210215020061000160, 18210215030081000160', current()))) or ($fullPeriod != '31/01') or ($docDate >= $apr01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($apr01)"/> (КС-56).
            </sch:assert>
            <sch:assert test="(not(contains('18210201000011000160, 18210209000061000160, 18210208000061000160, 18210204010011010160, 18210204010011020160, 18210204020011010160, 18210204020011020160, 18210210000011000160, 18210211000011000160, 18210215010061000160, 18210215020061000160, 18210215030081000160', current()))) or ($fullPeriod != '31/02') or ($docDate >= $may01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($may01)"/> (КС-57).
            </sch:assert>
            <sch:assert test="(not(contains('18210201000011000160, 18210209000061000160, 18210208000061000160, 18210204010011010160, 18210204010011020160, 18210204020011010160, 18210204020011020160, 18210210000011000160, 18210211000011000160, 18210215010061000160, 18210215020061000160, 18210215030081000160', current()))) or ($fullPeriod != '31/03') or ($docDate >= $jun01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($jun01)"/> (КС-58).
            </sch:assert>
            <sch:assert test="(not(contains('18210201000011000160, 18210209000061000160, 18210208000061000160, 18210204010011010160, 18210204010011020160, 18210204020011010160, 18210204020011020160, 18210210000011000160, 18210211000011000160, 18210215010061000160, 18210215020061000160, 18210215030081000160', current()))) or ($fullPeriod != '33/01') or ($docDate >= $jul01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($jul01)"/> (КС-59).
            </sch:assert>
            <sch:assert test="(not(contains('18210201000011000160, 18210209000061000160, 18210208000061000160, 18210204010011010160, 18210204010011020160, 18210204020011010160, 18210204020011020160, 18210210000011000160, 18210211000011000160, 18210215010061000160, 18210215020061000160, 18210215030081000160', current()))) or ($fullPeriod != '33/02') or ($docDate >= $aug01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($aug01)"/> (КС-60).
            </sch:assert>
            <sch:assert test="(not(contains('18210201000011000160, 18210209000061000160, 18210208000061000160, 18210204010011010160, 18210204010011020160, 18210204020011010160, 18210204020011020160, 18210210000011000160, 18210211000011000160, 18210215010061000160, 18210215020061000160, 18210215030081000160', current()))) or ($fullPeriod != '33/03') or ($docDate >= $sep01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($sep01)"/> (КС-61).
            </sch:assert>
            <sch:assert test="(not(contains('18210201000011000160, 18210209000061000160, 18210208000061000160, 18210204010011010160, 18210204010011020160, 18210204020011010160, 18210204020011020160, 18210210000011000160, 18210211000011000160, 18210215010061000160, 18210215020061000160, 18210215030081000160', current()))) or ($fullPeriod != '34/01') or ($docDate >= $oct01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($oct01)"/> (КС-62).
            </sch:assert>
            <sch:assert test="(not(contains('18210201000011000160, 18210209000061000160, 18210208000061000160, 18210204010011010160, 18210204010011020160, 18210204020011010160, 18210204020011020160, 18210210000011000160, 18210211000011000160, 18210215010061000160, 18210215020061000160, 18210215030081000160', current()))) or ($fullPeriod != '34/02') or ($docDate >= $nov01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($nov01)"/> (КС-63).
            </sch:assert>
            <sch:assert test="(not(contains('18210201000011000160, 18210209000061000160, 18210208000061000160, 18210204010011010160, 18210204010011020160, 18210204020011010160, 18210204020011020160, 18210210000011000160, 18210211000011000160, 18210215010061000160, 18210215020061000160, 18210215030081000160', current()))) or ($fullPeriod != '34/03') or ($docDate >= $dec01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($dec01)"/> (КС-64).
            </sch:assert>

            <!-- КС 65-67 -->

            <sch:assert test="(not(contains('18210501011011000110, 18210501021011000110', current()))) or ($fullPeriod != '34/01') or ($docDate >= $jan01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($jan01)"/> (КС-65).
            </sch:assert>
            <sch:assert test="(not(contains('18210501011011000110, 18210501021011000110', current()))) or ($fullPeriod != '34/02') or ($docDate >= $apr01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($apr01)"/> (КС-66).
            </sch:assert>
            <sch:assert test="(not(contains('18210501011011000110, 18210501021011000110', current()))) or ($fullPeriod != '34/03') or ($docDate >= $jul01)" role="WARNING">
                При данном КБК дата представления уведомления <sch:value-of select="go:format-date($docDate)"/> должна быть больше <sch:value-of select="go:format-date($jul01)"/> (КС-67).
            </sch:assert>

            <!-- КС 68 -->

            <sch:assert test="(not(contains('18210215010061000160, 18210215020061000160, 18210215030081000160', current()))) or ($year != '2023') or (not(contains('21/01, 21/02, 21/03, 31/01, 31/02, 31/03', $fullPeriod)))" role="WARNING">
                Отчетный период '<sch:value-of select="$fullPeriod"/>' недопустим при данном КБК для 2023 отчетного года (КС-68).
            </sch:assert>

            <!-- КС 85 -->

            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102130011000110, 18210102140011000110, 18210102080011000110, 18210102020011000110, 18210602010021000110, 18210602020021000110, 18210604011021000110, 18210606031031000110, 18210606032041000110, 18210606032111000110, 18210606032121000110, 18210606032141000110, 18210606033051000110, 18210606033101000110, 18210606033131000110, 18210102010011010110, 18210102080011010110', current()))) or empty($kpp) or ($kpp = '0') or (substring($kpp, 5, 2) != '50')" role="WARNING">
                Недопустимый КБК при КПП '<sch:value-of select="$kpp"/>' (КС-85).
            </sch:assert>

            <!-- КС 86 -->

            <sch:assert test="(not(contains('18210201000011000160, 18210209000061000160, 18210208000061000160, 18210204010011010160, 18210204010011020160, 18210204020011010160, 18210204020011020160, 18210210000011000160, 18210211000011000160, 18210215010061000160, 18210215020061000160, 18210215030081000160', current()))) or empty($kpp) or ($kpp = '0') or (substring($kpp, 5, 2) != '50')" role="WARNING">
                Недопустимый КБК при КПП '<sch:value-of select="$kpp"/>' (КС-85).
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern name="УЕНП-ОКТМО">
        <sch:rule context="Документ/УвИсчСумНалог/@ОКТМО">
            <sch:let name="kbk" value="go:safe-string(../@КБК)"/>

            <!-- КС 71 -->

            <sch:assert test="(not(contains('18210102010011010110, 18210102080011010110', $kbk))) or (current() = '21000000')" role="WARNING">
                Значение должно быть равно '21000000' при КБК '<sch:value-of select="$kbk"/>' (КС-71).
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern name="УЕНП-Год">
        <sch:rule context="Документ/УвИсчСумНалог/@Год">
            <sch:let name="kbk" value="go:safe-string(../@КБК)"/>

            <!-- КС 72-73 -->

            <sch:assert test="(not(contains('18210102010011000110, 18210102070011000110, 18210102080011000110, 18210102130011000110, 18210102140011000110, 18210102010011010110, 18210102080011010110', $kbk))) or (number(current()) >= 2023)" role="WARNING">
                Значение должно быть больше либо равно 2023 при КБК '<sch:value-of select="$kbk"/>' (КС-72).
            </sch:assert>

            <sch:assert test="(not(contains('18210201000011000160, 18210209000061000160, 18210208000061000160, 18210204010011010160, 18210204010011020160, 18210204020011010160, 18210204020011020160, 18210210000011000160, 18210211000011000160, 18210215010061000160, 18210215020061000160, 18210215030081000160', $kbk))) or (number(current()) >= 2023)" role="WARNING">
                Значение должно быть больше либо равно 2023 при КБК '<sch:value-of select="$kbk"/>' (КС-73).
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern name="Обязательное поле ИННФЛ для НПИП">
        <sch:rule context="Документ/СвНП/НПИП">
            <sch:assert test="@ИННФЛ and string-length(@ИННФЛ) > 0">
                Поле ИННФЛ обязательно для заполнения.
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern name="Проверка изменения предупреждения для Имени">
      <sch:rule context="Документ/Подписант/ФИО">
        <sch:assert test="@Имя">
          Изменённое сообщение: поле "Имя" обязательно для заполнения!
        </sch:assert>
      </sch:rule>
    </sch:pattern>

    <sch:pattern name="УЕНП-СумНалогАванс">
        <sch:rule context="Документ/УвИсчСумНалог/@СумНалогАванс">
            <sch:let name="kbk" value="go:safe-string(../@КБК)"/>
            <sch:let name="inn" value="go:one-of(../../СвНП/НПЮЛ/@ИННЮЛ, ../../СвНП/НПИП/@ИННФЛ)"/>
            <sch:let name="kpp" value="../@КППДекл"/>
            <sch:let name="year" value="go:safe-string(../@Год)"/>
            <sch:let name="period" value="go:safe-string(../@Период)"/>
            <sch:let name="month" value="go:safe-string(../@НомерМесКварт)"/>
            <sch:let name="fullPeriod" value="concat($period, '/', $month)"/>
            <sch:let name="sumPeriod34month0102" value="sum(../../УвИсчСумНалог[@Год = $year and @Период='34' and (@НомерМесКварт='01' or @НомерМесКварт='02')]/@СумНалогАванс)"/>
            <sch:let name="sumPeriod34month010203" value="sum(../../УвИсчСумНалог[@Год = $year and @Период='34' and (@НомерМесКварт='01' or @НомерМесКварт='02' or @НомерМесКварт='03')]/@СумНалогАванс)"/>
            <sch:let name="sumPeriod2131month04" value="sum(../../УвИсчСумНалог[@Год = $year and (@Период='21' or @Период='31') and @НомерМесКварт='04']/@СумНалогАванс)"/>
            <sch:let name="sumPeriod213133month04" value="sum(../../УвИсчСумНалог[@Год = $year and (@Период='21' or @Период='31' or @Период='33') and @НомерМесКварт='04']/@СумНалогАванс)"/>

            <!-- КС 74-75 -->

            <sch:assert test="(not(contains('18210501011011000110', $kbk))) or (current() &lt;= 200000000*0.08)" role="WARNING">
                Значение должно быть меньше либо равно <sch:value-of select="format-number(200000000*0.08, '0.##')"/> при КБК '<sch:value-of select="$kbk"/>' (КС-74).
            </sch:assert>
            <sch:assert test="(not(contains('18210501021011000110', $kbk))) or (current() &lt;= 200000000*0.2)" role="WARNING">
                Значение должно быть меньше либо равно <sch:value-of select="format-number(200000000*0.2, '0.##')"/> при КБК '<sch:value-of select="$kbk"/>' (КС-75).
            </sch:assert>

            <!-- КС 78-79, 81-82 -->

            <sch:assert test="(not(contains('18210501011011000110, 18210501021011000110', $kbk))) or ($fullPeriod != '34/02') or (current() >= 0) or ($sumPeriod34month0102 >= 0)" role="WARNING">
                Значение должно быть больше либо равно 0 при КБК '<sch:value-of select="$kbk"/>' и общей сумме за периоды 34/01 и 34/02 равной <sch:value-of select="format-number($sumPeriod34month0102, '0.##')"/> (КС-78).
            </sch:assert>
            <sch:assert test="(not(contains('18210501011011000110, 18210501021011000110', $kbk))) or ($fullPeriod != '34/03') or (current() >= 0) or ($sumPeriod34month010203 >= 0)" role="WARNING">
                Значение должно быть больше либо равно 0 при КБК '<sch:value-of select="$kbk"/>' и общей сумме за периоды 34/01, 34/02, 34/03 равной <sch:value-of select="format-number($sumPeriod34month010203, '0.##')"/> (КС-79).
            </sch:assert>
            <sch:assert test="(not(contains('18210102080011000110, 18210102020011000110', $kbk))) or (not(empty($kpp))) or ($kpp != '0') or (string-length($inn) != 12) or ($fullPeriod != '31/04') or (current() >= 0) or ($sumPeriod2131month04 >= 0)" role="WARNING">
                Значение должно быть больше либо равно 0 при КБК '<sch:value-of select="$kbk"/>' и общей сумме за периоды 21/04 и 31/04 равной <sch:value-of select="format-number($sumPeriod2131month04, '0.##')"/> (КС-81).
            </sch:assert>
            <sch:assert test="(not(contains('18210102080011000110, 18210102020011000110', $kbk))) or (not(empty($kpp))) or ($kpp != '0') or (string-length($inn) != 12) or ($fullPeriod != '33/04') or (current() >= 0) or ($sumPeriod213133month04 >= 0)" role="WARNING">
                Значение должно быть больше либо равно 0 при КБК '<sch:value-of select="$kbk"/>' и общей сумме за периоды 21/04, 31/04, 33/04 равной <sch:value-of select="format-number($sumPeriod213133month04, '0.##')"/> (КС-82).
            </sch:assert>

            <!-- КС 80 -->

            <sch:assert test="(not(contains('18210102080011000110, 18210102020011000110', $kbk))) or (not(empty($kpp))) or ($kpp != '0') or (string-length($inn) != 12) or ($fullPeriod != '21/04') or (current() >= 0)" role="WARNING">
                Значение должно быть больше либо равно 0 при КБК '<sch:value-of select="$kbk"/>' и отчетном периоде '<sch:value-of select="$fullPeriod"/>' (КС-80).
            </sch:assert>

            <!-- КС 83-84 -->

            <sch:assert test="(not(contains('18210101040011000110, 18210101070011000110, 18210101030011000110, 18210101050011000110, 18210102010011000110, 18210102070011000110, 18210102130011000110, 18210102140011000110, 18210201000011000160, 18210204010011010160, 18210204010011020160, 18210204020011010160, 18210204020011020160, 18210208000061000160, 18210209000061000160, 18210210000011000160, 18210211000011000160, 18210602010021000110, 18210602020021000110, 18210604011021000110, 18210606031031000110, 18210606032041000110, 18210606032111000110, 18210606032121000110, 18210606032141000110, 18210606033051000110, 18210606033101000110, 18210606033131000110, 18210503010011000110, 18210102010011010110, 18210215010061000160, 18210215020061000160, 18210215030081000160', $kbk))) or (current() >= 0)" role="WARNING">
                Значение должно быть больше либо равно 0 при КБК '<sch:value-of select="$kbk"/>' (КС-83).
            </sch:assert>
            <sch:assert test="(not(contains('18210102080011000110, 18210102080011010110', $kbk))) or (not(contains('21/01, 21/11, 21/02, 21/12, 21/03, 21/13, 31/01, 31/11, 31/02, 31/12, 31/03, 31/13, 33/01, 33/11, 33/02, 33/12, 33/03, 33/13, 34/01, 34/11, 34/02, 34/12, 34/03, 34/13', $fullPeriod))) or (current() >= 0)" role="WARNING">
                Значение должно быть больше либо равно 0 при КБК '<sch:value-of select="$kbk"/>' и отчетном периоде '<sch:value-of select="$fullPeriod"/>' (КС-84).
            </sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>
