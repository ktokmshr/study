from flask import Flask, render_template, request, url_for, redirect
from models.database import db_session
from models.models import Todo
from datetime import datetime, date, timedelta

app = Flask(__name__)

@app.route("/")
def index():
	todo_list = db_session.query(Todo)\
		.filter(Todo.status.in_([0, 1, 2])).all()
	return render_template("index.html", todo_list=todo_list)

@app.route("/add", methods=["post"])
def add():
	content = request.form.get("content")
	status = request.form.get("status")
	deadline = request.form.get("deadline")
	if not deadline:
		deadline = datetime.now() + timedelta(days=7)
		td = datetime.strptime(deadline.strftime("%Y-%m-%d"), "%Y-%m-%d")
	else:
		td = datetime.strptime(deadline, "%Y-%m-%d")
	deadline = date(td.year, td.month, td.day)
	todo = Todo(content, status, deadline)
	db_session.add(todo)
	db_session.commit()
	return redirect(url_for("index"))

@app.route("/delete", methods=["post"])
def delete():
	del_id_list = request.form.getlist("del_id")
	db_session.query(Todo)\
		.filter(Todo.id.in_(del_id_list))\
		.delete(synchronize_session='fetch')
	db_session.commit()
	return redirect(url_for("index"))

@app.route("/modify", methods=["post"])
def modify():
	mod_id = request.form.get("mod_id", "")
	if not mod_id:
		return redirect(url_for("index"))

	todo = db_session.query(Todo)\
		.filter(Todo.id == mod_id).first()
	return render_template("modify.html", todo=todo, mod_id=mod_id)

@app.route("/update", methods=["post"])
def update():
	mod_id = request.form.get("mod_id")
	content = request.form.get("content")
	status = request.form.get("status")
	deadline = request.form.get("deadline")
	td = datetime.strptime(deadline, "%Y-%m-%d")
	deadline = date(td.year, td.month, td.day)

	todo = db_session.query(Todo)\
		.filter(Todo.id == mod_id).first()
	todo.content = content
	todo.status = status
	todo.deadline = deadline
	db_session.commit()
	return redirect(url_for("index"))
