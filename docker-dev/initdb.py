from atomkobuta.factory import create_app
from atomkobuta.model import db
from atomkobuta.model import svs, hips

app = create_app()
with app.app_context():
    db.create_all()
    db.session.commit()
