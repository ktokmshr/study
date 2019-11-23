from sqlalchemy import Column, Integer, String, Date, Enum
from models.database import Base
from datetime import datetime, date
import enum


class Todo(Base):
	__tablename__ = "todo"
	id = Column(Integer, primary_key=True, autoincrement=True)
	content = Column(String(128), nullable=False)
	status = Column(Integer, default=1)
	deadline = Column(Date)

	def __init__(self, content=None, status=None, deadline=None):
		self.content = content
		self.status = status
		self.deadline = deadline

	def __repr__(self):
		return "content: {content}, status: {status}, deadline: {deadline}"\
			.format(content=self.content, status=self.status, deadline=self.deadline)
