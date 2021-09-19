from flask import Flask
from flask_restful import Resource, Api, reqparse
import ast
import uuid
import azure.cosmos.documents as documents
import azure.cosmos.cosmos_client as cosmos_client
import azure.cosmos.exceptions as exceptions
from azure.cosmos.partition_key import PartitionKey
import datetime
import config
import random
import string
import json

def get_random_key():
    # choose from all lowercase letter
    letters = string.ascii_lowercase
    result_str = ''.join(random.choice(letters) for i in range(4))
    number = random.randint(10,100)
    return result_str + str(number)

#config file not loaded as contains secrets
HOST = config.settings['host']
MASTER_KEY = config.settings['master_key']
DATABASE_ID = config.settings['database_id']
CONTAINER_ID = config.settings['container_id']


app = Flask(__name__)
api = Api(app)

def create_items(container,data):
    print('\nCreating Items\n')

    # Create a SalesOrder object. This object has nested properties and various types including numbers, DateTimes and strings.
    # This can be saved as JSON as is without converting into rows/columns.
    a = container.create_item(body=data)
    return a 

def query_items(container, id,passw):
    print('\nQuerying for an  Item by Partition Key\n')
    opts = {}
    opts['enableCrossPartitionQuery'] = True

    # Including the partition key value of account_number in the WHERE filter results in a more efficient query
    items = list(container.query_items(
        query="SELECT * FROM items c WHERE c.caseid=@caseid and c.pass=@pass",
        parameters=[{ "name":"@caseid", "value": id  },{"name":"@pass" , "value" : passw}], 
        enable_cross_partition_query=True
    ))
    return items


class cases(Resource):
    def get(self):
        parser = reqparse.RequestParser()  # initialize
        parser.add_argument('caseid', required=True)  # add args
        parser.add_argument('pass', required=True)
        args = parser.parse_args()  # parse arguments to dictionary
        client = cosmos_client.CosmosClient(HOST, {'masterKey': MASTER_KEY}, user_agent="CosmosDBPythonQuickstart", user_agent_overwrite=True)
        try:
           
            db = client.get_database_client(DATABASE_ID)
            print('Database with id \'{0}\' created'.format(DATABASE_ID))
            container = db.get_container_client(CONTAINER_ID)
            output = query_items(container,args['caseid'],args['pass'])
            if output != []:
                return {'data': output}, 200
            else:
                return {},404
        except exceptions.CosmosHttpResponseError as e:
            print('\nrun_sample has caught an error. {0}'.format(e.message))
            return {'data': 'error'}, 500  # return data and 200 OK code


    def post(self):
        parser = reqparse.RequestParser()  # initialize
        parser.add_argument('caseid', required=True)  # add args
        parser.add_argument('workspace', required=True)
        parser.add_argument('wid', required=True)
        
        args = parser.parse_args()  # parse arguments to dictionary
        
        # create new dataframe containing new values
        new_data = {
            'id': uuid.uuid4().hex,
            'caseid': args['caseid'],
            'workspace': args['workspace'],
            'wid': args['wid'],
            'pass': get_random_key(),
            'ttl': 600
        }



        client = cosmos_client.CosmosClient(HOST, {'masterKey': MASTER_KEY}, user_agent="CosmosDBPythonQuickstart", user_agent_overwrite=True)
        try:
           
            db = client.get_database_client(DATABASE_ID)
            print('Database with id \'{0}\' created'.format(DATABASE_ID))
            container = db.get_container_client(CONTAINER_ID)
            aux = create_items(container,new_data)
            return aux, 200  # return data with 200 OK
        except exceptions.CosmosHttpResponseError as e:
            print('\nrun_sample has caught an error. {0}'.format(e.message))
            return {e.message} , 500
            
    
api.add_resource(cases, '/cases')  

#if __name__ == '__main__':
#    app.run()  # run our Flask app

if __name__ == '__main__':
    app.run(host='0.0.0.0')