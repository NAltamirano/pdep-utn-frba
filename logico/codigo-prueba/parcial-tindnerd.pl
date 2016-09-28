usa(tinder, gerardo).
usa(tinder, graciela).
usa(tinder, sergio).
usa(tinder, tana).
usa(tinder, anahi).
usa(badoo, renata).
usa(badoo, sergio).
usa(xxx, renata).
usa(badoo, raul).
usa(facebook, dodain).

casado(gerardo, lorena).
casado(sergio, renata).

redSocialHot(tinder).
redSocialHot(badoo).
redSocialHot(xxx).

% Punto 1
usa(Red,claudio) :- usa(Red,renata).
usa(twitter,Alguien) :- usa(tinder,Alguien).
usa(twitter,Alguien) :- usa(badoo,Alguien).

% No es necesario, ya que por universo cerrado, si no está declarado, es falso.
laCaretean(PersonaA,PersonaB) :- casado(PersonaA,PersonaB), usa(RedSocialA,PersonaA), usa(RedSocialB,PersonaB), redSocialHot(RedSocialA), redSocialHot(RedSocialB), RedSocialA \= RedSocialB, PersonaA \= PersonaB.