module env

import rand

const (
	chengyu = ['bu', 'cha', 'gu', 'li', 'pyu', 'sha', 'tsu', 'xi', 'ya', 'ji', 'yu', 'qi', 'go', 'ni']                                                           // xin-xi
	praetor = ['ium', 'ia', 'et', 'ip', 'ca', 'do', 'ica', 'lo', 'lus', 'ma', 'mo', 'mus', 'nu', 'pi', 're', 'res', 'ro', 'sum', 'te']                           // imperius
	hargor  = ['ur', 'ark', 'bu', 'fla', 'gru', 'gu', 'lak', 'lin', 'ork', 'rø', 'tof', 'heim', 'hus', 'kau']                                                    // bardur
	ghalim  = ['ha', 'gh', 'on', 'ba', 'dor', 'ji', 'ke', 'la', 'lim', 'mu', 'si', 'ye', 'tu', 'gu', 'ko', 'to', 'zwe']                                          // oumaji
	luhama  = ['an', 'ko', 'li', 'lo', 'lu', 'ma', 'no', 'nu', 'oki', 'si', 'va', 'ha', 'muk', 'oo']                                                             // kickoo
	ferthin = ['ol', 'ple', 'th', 'ber', 'don', 'go', 'ick', 'in', 'ley', 'lo', 'ry', 'wa', 'we', 'wy', 'uth', 'en', 'ty']                                       // hoodrick
	zegde   = ['ie', 'am', 'erd', 'el', 'ste', 'zum', 'we']                                                                                                      // luxidoor but dutch
	alumk   = ['rz', 'th', 'cth', 'nt', 'ar', 'bu', 'ck', 'dis', 'gor', 'he', 'im', 'na', 'pe', 'rot',  'st', 'tu', 'xas']                                       // vengir
	yeouma  = ['bo', 'co', 'la', 'mo', 'wa', 'ya', 'za', 'zan', 'zim', 'zu', 'ta', 'do', 'dim', 'ou']                                                            // zebasi
	sulai   = ['yy', 'uu', 'dee', 'fï', 'kï', 'lee', 'lï', 'nï', 'pö', 'pï', 'so', 'sï', 'to', 'tï', 'lä', 'nä', 'ii', 'po']                                     // ai-mo, but finnish-inspired
	tzatli  = ['el', 'ca', 'cho', 'chu', 'ex', 'ill', 'ix', 'ja', 'qu', 'tal', 'tek', 'tz', 'was', 'wop', 'ya', 'ma', 'az']                                      // quetzali
	hu_ur   = ['ar', 'ark', 'az', 'ber', 'ez', 'ge', 'gy', 'kh', 'ki', 'kol', 'ka', 'mer', 'ol', 'sam', 'sh', 'st', 'tja', 'tsa', 'ug', 'urk', 'ul', 'um', 'an'] // yadakk, stylized as hu'ur
)

[inline]
fn ends_with_any(s string, sum string) bool {
	for i in sum {
		if s.ends_with(i.ascii_str()) { return true }
	}
	return false
}

[inline]
fn random(tribe []string, l int, h int) ?string {
	return tribe[rand.int_in_range(l, h)?]
}

pub fn gen_chengyu() ?string {
	mut first := random(chengyu, 0, chengyu.len)?

	if rand.u8() > 192  {
		first += '-'
	}

	return first + random(chengyu, 0, chengyu.len)?
}

pub fn gen_praetor() ?string {
	first := random(praetor, 0, praetor.len)?
	mut second := ''
	// only generate a 3 letter name every so often
	if rand.u8() > 192  {
		second = random(praetor, 0, praetor.len)?
		if second == first {
			second = ''
		}
	}

	mut last := ''
	if ends_with_any(first, 'aeiou') {
		last = random(praetor, 4, praetor.len)? // ignore endings that would cause major vowel clashes (eg maip)
	} else {
		last = random(praetor, 0, praetor.len)?
	}

	return '$first$second$last'
}

pub fn gen_hargor() ?string {
	first := random(hargor, 0, hargor.len)?

	mut last := ''
	if ends_with_any(first, 'aeiouk') {
		last = random(hargor, 2, hargor.len)? // ignore ur and ark as last
	} else {
		last = random(hargor, 0, hargor.len)?
	}

	return '$first$last'
}

pub fn gen_ghalim() ?string {
	first := random(ghalim, 0, ghalim.len)?

	if first.ends_with('h') {
		last := random(ghalim, 2, ghalim.len)? // ignores ha and gh as last, prevents double h (like in ghha)
		return '$first$last'
	}

	last := random(ghalim, 0, ghalim.len)?
	return '$first$last'
}

[inline]
pub fn gen_luhama() ?string {
	return random(luhama, 0, luhama.len)? + random(luhama, 0, luhama.len)? + random(luhama, 0, luhama.len)?
}

pub fn gen_ferthin() ?string {
	first := random(ferthin, 3, ferthin.len)? // ignores ol, ple and th as first
	mut last := random(ferthin, 1, ferthin.len)? // ignores ol as last
	for last == first {
		last = random(ferthin, 1, ferthin.len)?
	}
	return '$first$last'
}

[inline]
pub fn gen_zegde() ?string {
	if rand.u8() < 64 {
		return random(zegde, 1, zegde.len)? + random(zegde, 0, zegde.len)?
	}
	return random(zegde, 1, zegde.len)? + random(zegde, 0, zegde.len)? + random(zegde, 0, zegde.len)?
}

[inline]
pub fn gen_alumk() ?string {
	return random(alumk, 4, alumk.len)? + random(alumk, 0, alumk.len)? + random(alumk, 0, alumk.len)?
}

[inline]
pub fn gen_yeouma() ?string {
	if rand.u8() < 100 {
		return random(yeouma, 0, yeouma.len)? + random(yeouma, 0, yeouma.len)?
	}
	return random(yeouma, 0, yeouma.len)? + random(yeouma, 0, yeouma.len)? + random(yeouma, 0, yeouma.len)?
}

[inline]
pub fn gen_sulai() ?string {
	return random(sulai, 0, sulai.len)? + random(sulai, 2, sulai.len)?
}

pub fn gen_tzatli() ?string {
	return random(tzatli, 0, tzatli.len)? + random(tzatli, 0, tzatli.len)? 
}

pub fn gen_hu_ur() ?string {
	if rand.u8() < 100 {
		return random(hu_ur, 0, hu_ur.len)? + random(hu_ur, 0, hu_ur.len)?
	}
	return random(hu_ur, 0, hu_ur.len)? + random(hu_ur, 0, hu_ur.len)? + random(hu_ur, 0, hu_ur.len)?
}