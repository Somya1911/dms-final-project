from flask import Flask, render_template, redirect, url_for, request
from flask_sqlalchemy import SQLAlchemy
from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField
from wtforms.validators import DataRequired
from urllib.parse import quote_plus
import pandas as pd

# Initialize Flask app
app = Flask(__name__)
app.config['SECRET_KEY'] = 'YourSecretKey'  # Change this to a random secret key

# Your password containing special characters
password = 'Nikki@1234'

# Encode the password
encoded_password = quote_plus(password)

# Use the encoded password in the URI
app.config['SQLALCHEMY_DATABASE_URI'] = f'mysql://root:{encoded_password}@34.148.238.221/dbms'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Initialize SQLAlchemy
db = SQLAlchemy(app)

# Define the Customer model
class Customer(db.Model):
    customer_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    first_name = db.Column(db.String(255), nullable=False)
    last_name = db.Column(db.String(255), nullable=False)
    email = db.Column(db.String(255), nullable=False)
    country = db.Column(db.String(100), nullable=False)

# Define the CustomerForm
class CustomerForm(FlaskForm):
    first_name = StringField('First Name', validators=[DataRequired()])
    last_name = StringField('Last Name', validators=[DataRequired()])
    email = StringField('Email', validators=[DataRequired()])
    country = StringField('Country', validators=[DataRequired()])
    submit = SubmitField('Submit')

@app.route('/')
def home():
    return render_template('index.html')


# Route to display and process the form for adding customers
@app.route('/add_customer', methods=['GET', 'POST'])
def add_customer():
    form = CustomerForm()
    if form.validate_on_submit():
        new_customer = Customer(
            first_name=form.first_name.data,
            last_name=form.last_name.data,
            email=form.email.data,
            country=form.country.data
        )
        db.session.add(new_customer)
        db.session.commit()
        print("Database updated")  # Print the statement
        return redirect(url_for('add_customer'))
    return render_template('add_customer.html', form=form)

# Route to display the customer lookup form and handle customer lookup
@app.route('/customer_lookup', methods=['GET', 'POST'])
def customer_lookup():
    try:
        df = pd.read_csv('Predicted CLV Results.csv')
    except Exception as e:
        # Log the exception or print it to the console
        print(f"Error reading CSV file: {e}")

    if request.method == 'POST':
        customer_id = request.form['customer_id']
        try:
            customer_id_int = int(customer_id)
            data = df[df['Customer ID'] == customer_id_int]
        except ValueError:
            return render_template('customer_lookup.html', error_message="Please enter a valid Customer ID.")
        except Exception as e:
            return render_template('customer_lookup.html', error_message=f"An error occurred: {e}")

        if data.empty:
            return render_template('customer_lookup.html', not_found_message="No data found for this Customer ID.")
        else:
            # Convert the data to HTML table
            result = data.to_html(classes='table table-striped')
            return render_template('customer_lookup.html', result=result)

    return render_template('customer_lookup.html')

@app.route('/dashboard')
def dashboard():
    return render_template('dashboard.html')

