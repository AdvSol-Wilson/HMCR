import React, { useEffect, useState } from 'react';
import { connect } from 'react-redux';
import * as Yup from 'yup';
import moment from 'moment';

import SingleDateField from '../ui/SingleDateField';
import MultiSelect from '../ui/MultiSelect';
import SingleDropdownField from '../ui/SingleDropdownField';
import PageSpinner from '../ui/PageSpinner';
import { FormRow, FormInput, FormCheckboxInput } from './FormInputs';

import * as api from '../../Api';
import * as Constants from '../../Constants';
import { Row,Col} from 'reactstrap';

const defaultValues = {
  activityNumber: '',
  activityName: '',
  unitOfMeasure: '',
  maintenanceType: '',
  locationCodeId: '',
  featureType: '',
  spThresholdLevel: '',
  minimumValue: '',
  maximumValue:'',
  reportingFrequency: '',
  roadLengthRule: '',
  surfaceTypeRule: '',
  roadClassRule: '',
  isSiteNumRequired: false,
  serviceAreaNumbers: [],
  endDate: null,
};

const validationSchema = Yup.object({
  activityNumber: Yup.string()
    .matches(/^[a-z0-9]+$/i, 'Numbers or letters only')
    .required('Required')
    .max(6)
    .trim(),
  activityName: Yup.string().required('Required').max(150).trim(),
  unitOfMeasure: Yup.string().required('Required').max(12),
  maintenanceType: Yup.string().required('Required').max(12),
  locationCodeId: Yup.number().required('Required'),
  serviceAreaNumbers: Yup.array().required('At least one Service Area must be selected'),
  minimumValue: Yup.number()
    .min(0)
    .typeError('Must be number')
    .when('unitOfMeasure', {
      is:'site',
      then:Yup.number().integer(),
    }),
  maximumValue: Yup.number()
    .min(0)
    .typeError('Must be number')
    .when('unitOfMeasure', {
      is:'site',
      then:Yup.number().integer(),
    }),
  reportingFrequency: Yup.number()
    .min(0)
    .max(365)
    .typeError('Must be number')
    .integer(),

  
});
const EditActivityFormFields = ({
  setInitialValues,
  formValues,
  setValidationSchema,
  formType,
  activityId,
  maintenanceTypes,
  unitOfMeasures,
  locationCodes,
  featureTypes,
  thresholdLevels,
  roadLengthRules,
  surfaceTypeRules,
  roadClassRules,
  serviceAreas,
}) => {
  const [loading, setLoading] = useState(true);
  const [validLocationCodeValues, setValidLocationCodeValues] = useState(locationCodes);
  const [disableLocationCodeEdit, setDisableLocationCodeEdit] = useState(false);
  const [validFeatureTypeValues, setValidFeatureTypeValues] = useState(featureTypes);
  const locationCodeCId = locationCodes.find((code) => code.name === 'C').id;

  useEffect(() => {
    // Add validation for point line feature when location code is C.
    // Need to get the id value of location code C
    const defaultValidationSchema = validationSchema.shape({
      featureType: Yup.string()
        .nullable()
        .when('locationCodeId', {
          is: locationCodeCId,
          then: Yup.string().required('Required').max(12),
        }),
      spThresholdLevel: Yup.string()
        .nullable()
        .when('locationCodeId', {
          is: locationCodeCId,
          then: Yup.string().required('Required'),
        }),
      isSiteNumRequired: Yup.boolean().when('locationCodeId', {
        is: locationCodeCId,
        then: Yup.boolean().required('Required'),
      }),
    });

    setValidationSchema(defaultValidationSchema);

    setLoading(true);

    if (formType === Constants.FORM_TYPE.ADD) {
      setInitialValues(defaultValues);
      setLoading(false);
    } else {
      api.getActivityCode(activityId).then((response) => {
        setInitialValues({
          ...response.data,
          endDate: response.data.endDate ? moment(response.data.endDate) : null,
        });

        setValidLocationCodeValues(() => {
          if (formType === Constants.FORM_TYPE.EDIT) {
            if (response.data.locationCodeId === locationCodes.find((code) => code.name === 'B').id)
              return locationCodes.filter((location) => location.name !== 'C');
          }

          return locationCodes;
        });

        setDisableLocationCodeEdit(() => {
          if (formType === Constants.FORM_TYPE.EDIT) {
            if (response.data.locationCodeId === locationCodes.find((code) => code.name === 'A').id) return true;
          }
          return false;
        });

        setValidFeatureTypeValues(() => {
          const pointLineType = 'Point/Line';

          if (formType === Constants.FORM_TYPE.EDIT) {
            if (response.data.featureType === pointLineType)
              return featureTypes.filter((feature) => feature.id === pointLineType);

            if (response.data.featureType)
              return featureTypes.filter(
                (feature) => feature.id === pointLineType || feature.id === response.data.featureType
              );
          }

          return featureTypes;
        });

        setLoading(false);
      });
    }

    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  if (loading || formValues === null) return <PageSpinner />;
  
  return (
    <React.Fragment>
      <Row>
        <Col>
          <FormRow name="activityNumber" label="Activity Code*">
            <FormInput
              type="text"
              name="activityNumber"
              placeholder="Activity Code"
              disabled={formType === Constants.FORM_TYPE.EDIT}
            />
          </FormRow>
        </Col>
        <Col>
          <FormRow name="activityName" label="Activity Name*">
            <FormInput type="text" name="activityName" placeholder="Activity Name" />
          </FormRow>
        </Col>
      </Row>
      <Row>
        <Col>
          <FormRow name="unitOfMeasure" label="Unit*">
            <SingleDropdownField
              defaultTitle="Select Unit"
              items={unitOfMeasures}
              name="unitOfMeasure"
              disabled={formType === Constants.FORM_TYPE.EDIT}
            />
          </FormRow>
        </Col>
        <Col>
          <FormRow name="maintenanceType" label="Maintenance Type*">
            <SingleDropdownField
              defaultTitle="Select Maintenance Type"
              items={maintenanceTypes}
              name="maintenanceType"
              disabled={formType === Constants.FORM_TYPE.EDIT}
            />
          </FormRow>
        </Col>
      </Row>
      <Row>
        <Col className='col colmargin1'>
          <FormRow name="serviceAreaNumbers" label="Service Areas*">
            <MultiSelect selectClass ="form-control servicearea-large" items={serviceAreas} name="serviceAreaNumbers" showSelectAll={true} />
          </FormRow>
        </Col>
        <Col>
          <fieldset className='form-control fieldset'>
           <legend className='form-control legend'>Analytical Validation</legend>
            <FormRow name="minimumValue" label="Minimum Value">
              <FormInput type="text" name="minimumValue" placeholder="Minimum Value" />
            </FormRow>
            <FormRow name="maximumValue" label="Maximum Value">
              <FormInput type="text" name="maximumValue" placeholder="Maximum Value" />
            </FormRow>
            <FormRow name="reportingFrequency" label="Reporting Frequency (Minimum # Days)">
              <FormInput type="text" name="reportingFrequency" placeholder="ReportingFrequency (Minimum # Days)" />
            </FormRow>
          </fieldset>
        </Col>
      </Row>
      <Row>
        <Col>
          <FormRow name="locationCodeId" label="Location Code*">
            <SingleDropdownField
              defaultTitle="Select Location Code"
              items={validLocationCodeValues}
              name="locationCodeId"
              disabled={disableLocationCodeEdit}
            />
          </FormRow>
            {formValues.locationCodeId === locationCodeCId && (
              <React.Fragment>
                <FormRow name="featureType" label="Feature Type*">
                  <SingleDropdownField defaultTitle="Select Feature Type" items={validFeatureTypeValues} name="featureType" />
                </FormRow>
                <FormRow name="spThresholdLevel" label="Location Tolerance Level*">
                  <SingleDropdownField
                    defaultTitle="Select Location Tolerance Level"
                    items={thresholdLevels}
                    name="spThresholdLevel"
                  />
                </FormRow>
                </React.Fragment>
            )}
            </Col>
            <Col>
      {formValues.locationCodeId === locationCodeCId && (
          <React.Fragment>
            
          <FormRow name="roadLengthRule" label="Road Length Validation Rule">
            <SingleDropdownField
              defaultTitle="Not Applicable"
              items={roadLengthRules}
              name="roadLengthRule"
            />
          </FormRow>
          <FormRow name="surfaceTypeRule" label="Surface Type Rule">
            <SingleDropdownField
              defaultTitle="Not Applicable"
              items={surfaceTypeRules}
              name="surfaceTypeRule"
            />
          </FormRow>
            <FormRow name="roadClassRule" label="Road Class Rule">
            <SingleDropdownField
              defaultTitle="Not Applicable"
              items={roadClassRules}
              name="roadClassRule"
            />
          </FormRow>
         
        </React.Fragment>
      )}
       </Col>
       </Row>
       <Row>
        <Col>
        {formValues.locationCodeId === locationCodeCId && (
          <React.Fragment>
          <FormRow name="isSiteNumRequired" label="Site Number Required">
            <FormCheckboxInput name="isSiteNumRequired" />
          </FormRow>
          </React.Fragment>
      )}
        </Col>
         <Col>
         
          <FormRow name="endDate" label="End Date">
            <SingleDateField name="endDate" placeholder="End Date" />
          </FormRow>
        </Col>
      </Row>
    </React.Fragment>
  );
};

const mapStateToProps = (state) => {
  return {
    maintenanceTypes: state.codeLookups.maintenanceTypes,
    unitOfMeasures: state.codeLookups.unitOfMeasures,
    locationCodes: state.codeLookups.locationCodes,
    featureTypes: state.codeLookups.featureTypes,
    thresholdLevels: state.codeLookups.thresholdLevels,
    roadLengthRules: state.codeLookups.roadLengthRules,
    surfaceTypeRules: state.codeLookups.surfaceTypeRules,
    roadClassRules: state.codeLookups.roadClassRules,
    serviceAreas: Object.values(state.serviceAreas),
  };
};

export default connect(mapStateToProps)(EditActivityFormFields);
